{
  services.cron = {
    enable = true;
    systemCronJobs = [
      ''*/1 * * * *    chen    for d in /var/git/*.git ; do cd "$d"; git fetch; done''
    ];
  };
}