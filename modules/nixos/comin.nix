{}: {
  services.comin = {
    enable = true;
    remotes = [{
      name = "origin";
      url = "https://github.com/Dauliac/minecraft.git";
      branches.main.name = "main";
    }];
  };
}
