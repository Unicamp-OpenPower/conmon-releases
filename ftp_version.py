import requests
# find and save the current Github release
html = str(
    requests.get('https://github.com/containers/conmon/releases/latest')
    .content)
index = html.find('Release v')
github_version = html[index + 9:index + 15]
file = open('github_version.txt', 'w')
file.writelines(github_version)
file.close()

# find and save the current Bazel version on FTP server
html = str(
    requests.get(
        'https://oplab9.parqtec.unicamp.br/pub/ppc64el/conmon/latest'
    ).content)
index = html.rfind('conmon-')
ftp_version = html[index + 7:index + 13]
file = open('ftp_version.txt', 'w')
file.writelines(ftp_version)
file.close()

# find and save the oldest Bazel version on FTP server
html = str(
    requests.get(
        'https://oplab9.parqtec.unicamp.br/pub/ppc64el/conmon'
    ).content)
index = html.find('conmon-')
delete = html[index + 7:index + 13]
file = open('delete_version.txt', 'w')
file.writelines(delete)
file.close()
