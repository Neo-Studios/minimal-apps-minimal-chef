import React, { createContext, useContext, useState, useEffect } from 'react';

interface User {
  email: string;
  username: string;
  hash: string;
}

interface AuthContextType {
  user: User | null;
  login: (email: string) => Promise<boolean>;
  register: (username: string, email: string) => Promise<boolean>;
  verifyCode: (code: string) => Promise<boolean>;
  logout: () => void;
  isLoading: boolean;
}

const AuthContext = createContext<AuthContextType | undefined>(undefined);

export const useAuth = () => {
  const context = useContext(AuthContext);
  if (!context) throw new Error('useAuth must be used within AuthProvider');
  return context;
};

export const AuthProvider: React.FC<{ children: React.ReactNode }> = ({ children }) => {
  const [user, setUser] = useState<User | null>(null);
  const [isLoading, setIsLoading] = useState(true);

  useEffect(() => {
    const savedUser = localStorage.getItem('minimalChefUser');
    const sessionExpiry = localStorage.getItem('minimalChefSession');
    
    if (savedUser && sessionExpiry) {
      const now = new Date().getTime();
      if (now < parseInt(sessionExpiry)) {
        setUser(JSON.parse(savedUser));
      } else {
        localStorage.removeItem('minimalChefUser');
        localStorage.removeItem('minimalChefSession');
      }
    }
    setIsLoading(false);
  }, []);

  const register = async (username: string, email: string): Promise<boolean> => {
    try {
      const response = await fetch('/api/auth/register', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ username, email })
      });
      return response.ok;
    } catch {
      return false;
    }
  };

  const login = async (email: string): Promise<boolean> => {
    try {
      const response = await fetch('/api/auth/login', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ email })
      });
      return response.ok;
    } catch {
      return false;
    }
  };

  const verifyCode = async (code: string): Promise<boolean> => {
    try {
      const response = await fetch('/api/auth/verify', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ code })
      });
      
      if (response.ok) {
        const userData = await response.json();
        setUser(userData.user);
        
        const sessionExpiry = new Date().getTime() + (7 * 24 * 60 * 60 * 1000);
        localStorage.setItem('minimalChefUser', JSON.stringify(userData.user));
        localStorage.setItem('minimalChefSession', sessionExpiry.toString());
        return true;
      }
      return false;
    } catch {
      return false;
    }
  };

  const logout = () => {
    setUser(null);
    localStorage.removeItem('minimalChefUser');
    localStorage.removeItem('minimalChefSession');
  };

  return (
    <AuthContext.Provider value={{ user, login, register, verifyCode, logout, isLoading }}>
      {children}
    </AuthContext.Provider>
  );
};