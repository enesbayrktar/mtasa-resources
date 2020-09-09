const path = require("path");

class Commands {
  constructor(client) {
    this._client = client;
    this._registeredCommands = [];
  }

  register(commandName, callback) {
    this._registeredCommands.push({ commandName, callback });

    return this;
  }

  use(cmd, args, message, server) {
    return new Promise((resolve, reject) => {
      const command = this._registeredCommands.find(
        item => item["commandName"] === cmd
      );
      if (command === undefined) return reject();
      command.callback(args, message, server);
    });
  }

  list() {
    let list = [];

    this._registeredCommands.forEach(item => {
      list.push(item.commandName);
    });

    return list;
  }
}

module.exports = Commands;
