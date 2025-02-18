/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    "./src/**/*.{js,jsx,ts,tsx}",
  ],
  theme: {
    extend: {      
      colors: {
        primary: "#133E87",  // Deep Blue
        secondary: "#608BC1", // Medium Blue
        background: "#ffffff", // Soft Off-White
        accent: "#CBDCEB", // Light Blue
        danger: "#AA3A3A",   // Keeping Dark Red for alerts instead of red
      },
    },
  },
  plugins: [],
};


