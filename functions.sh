PrintTimestamp()
{
  echo "[$(date --utc '+%Y/%m/%d %H:%M:%SZ')]"
}

PrintHelp()
{
  man ./files/deploy_cloud.8
}
