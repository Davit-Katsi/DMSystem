const fs = require('fs');
const path = require('path');
const winston = require('winston');

// Define log directory
const logDir = path.join(__dirname, '../logs');
if (!fs.existsSync(logDir)) {
    fs.mkdirSync(logDir);
}

// Create Winston Logger
const logger = winston.createLogger({
    level: 'info',
    format: winston.format.combine(
        winston.format.timestamp(),
        winston.format.printf(({ timestamp, level, message }) => {
            return `${timestamp} [${level.toUpperCase()}] - ${message}`;
        })
    ),
    transports: [
        new winston.transports.File({ filename: path.join(logDir, 'activity.log') }) // Log file
    ]
});

// Function to log actions
const logAction = (user, action, details = '') => {
    const logMessage = `User: ${user || 'Unknown'}, Action: ${action}, Details: ${details}`;
    logger.info(logMessage);
};

// Automatically delete logs older than 1 month
const cleanOldLogs = () => {
    const logFile = path.join(logDir, 'activity.log');
    if (fs.existsSync(logFile)) {
        const stats = fs.statSync(logFile);
        const oneMonthAgo = new Date();
        oneMonthAgo.setMonth(oneMonthAgo.getMonth() - 1);
        
        if (stats.mtime < oneMonthAgo) {
            fs.unlinkSync(logFile);
            console.log("Old logs deleted.");
        }
    }
};

// Run cleanup on startup
cleanOldLogs();

module.exports = { logAction };
