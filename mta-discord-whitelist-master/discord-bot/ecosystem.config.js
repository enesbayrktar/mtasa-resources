module.exports = {
  apps: [
    {
      name: "dc-whitelist",
      script: "index.js",
      watch: ["commands", "libs", "index.js"],
      watch_delay: 500,
      ignore_watch: ["node_modules"],
      watch_options: {
        followSymlinks: false,
      },
    },
  ],
};
