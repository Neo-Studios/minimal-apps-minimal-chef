import React, { createContext, useContext, useState, useEffect } from 'react';

interface DebugContextType {
  isDebugMode: boolean;
  debugLogs: string[];
  addDebugLog: (message: string) => void;
  clearDebugLogs: () => void;
}

const DebugContext = createContext<DebugContextType | undefined>(undefined);

export const useDebug = () => {
  const context = useContext(DebugContext);
  if (!context) throw new Error('useDebug must be used within DebugProvider');
  return context;
};

export const DebugProvider: React.FC<{ children: React.ReactNode }> = ({ children }) => {
  const [isDebugMode, setIsDebugMode] = useState(false);
  const [debugLogs, setDebugLogs] = useState<string[]>([]);

  useEffect(() => {
    // Add global debug command
    (window as any).debug = (command: string) => {
      if (command === '--on') {
        const confirmed = window.confirm(
          '⚠️ WARNING: Debug mode will expose internal application data and may affect performance. Only enable for development/testing purposes. Continue?'
        );
        if (confirmed) {
          setIsDebugMode(true);
          console.log('🐛 Debug mode activated');
          addDebugLog('Debug mode activated');
        }
      } else if (command === '--off') {
        setIsDebugMode(false);
        setDebugLogs([]);
        console.log('🐛 Debug mode deactivated');
      } else {
        console.log('Debug commands: debug("--on") or debug("--off")');
      }
    };

    return () => {
      delete (window as any).debug;
    };
  }, []);

  const addDebugLog = (message: string) => {
    const timestamp = new Date().toLocaleTimeString();
    setDebugLogs(prev => [...prev, `[${timestamp}] ${message}`]);
  };

  const clearDebugLogs = () => {
    setDebugLogs([]);
  };

  return (
    <DebugContext.Provider value={{ isDebugMode, debugLogs, addDebugLog, clearDebugLogs }}>
      {children}
    </DebugContext.Provider>
  );
};