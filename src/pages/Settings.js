import React from 'react';
import {
  Box,
  Typography,
  List,
  ListItem,
  ListItemText,
  ListItemSecondaryAction,
  Switch,
  Paper,
  Divider,
} from '@mui/material';
import { useTheme } from '../hooks/useTheme';

const Settings = () => {
  const { isDarkMode, toggleTheme } = useTheme();

  return (
    <Box>
      <Typography variant="h4" component="h1" gutterBottom>
        Settings
      </Typography>

      <Paper>
        <List>
          <ListItem>
            <ListItemText
              primary="Dark Mode"
              secondary="Switch between light and dark themes"
            />
            <ListItemSecondaryAction>
              <Switch
                checked={isDarkMode}
                onChange={toggleTheme}
              />
            </ListItemSecondaryAction>
          </ListItem>
          <Divider />
          <ListItem>
            <ListItemText
              primary="Voice Commands"
              secondary="Enable voice control for recipe instructions"
            />
            <ListItemSecondaryAction>
              <Switch defaultChecked />
            </ListItemSecondaryAction>
          </ListItem>
          <Divider />
          <ListItem>
            <ListItemText
              primary="Text-to-Speech"
              secondary="Read recipe instructions aloud"
            />
            <ListItemSecondaryAction>
              <Switch defaultChecked />
            </ListItemSecondaryAction>
          </ListItem>
          <Divider />
          <ListItem>
            <ListItemText
              primary="Instacart Integration"
              secondary="Connect with Instacart for grocery delivery"
            />
            <ListItemSecondaryAction>
              <Switch />
            </ListItemSecondaryAction>
          </ListItem>
        </List>
      </Paper>
    </Box>
  );
};

export default Settings;