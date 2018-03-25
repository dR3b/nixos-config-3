{
  _module.args = {
    secrets = {
      # Utility functions
      mkSecret = name: options: {
        "${name}" = {
          source = ../../secrets/. + "/${name}";
        } // options;
      };

      getSecret = name: "/etc/secrets/" + name;
    } // (import ../../secrets);
  };
}
