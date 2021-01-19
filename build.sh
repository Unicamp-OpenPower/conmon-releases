github_version=$(cat github_version.txt)
ftp_version=$(cat ftp_version.txt)
del_version=$(cat delete_version.txt)

if [ $github_version != $ftp_version ]
then
  git clone https://github.com/containers/conmon.git
  cd conmon
  git checkout v$github_version
  make
  cd bin
  ./conmon --version
  mv conmon conmon-$github_version
  ls

  lftp -c "open -u $USER,$PASS ftp://oplab9.parqtec.unicamp.br; rm /ppc64el/conmon/latest/conmon-$ftp_version"
  lftp -c "open -u $USER,$PASS ftp://oplab9.parqtec.unicamp.br; put -O /ppc64el/conmon/latest conmon-$github_version"
  lftp -c "open -u $USER,$PASS ftp://oplab9.parqtec.unicamp.br; put -O /ppc64el/conmon conmon-$github_version"
  #lftp -c "open -u $USER,$PASS ftp://oplab9.parqtec.unicamp.br; rm /ppc64el/conmon/conmon-$del_version"
fi
