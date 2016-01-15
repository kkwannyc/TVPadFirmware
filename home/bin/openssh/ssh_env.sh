#/bin/sh

mkdir /root/.ssh > /dev/null 2>&1
mkdir /var/empty > /dev/null 2>&1

echo sshd:x:112:65534::/var/run/sshd:/usr/sbin/nologin >> /etc/passwd
echo ssh:x:109: >> /etc/group
echo sshd:*:14890:0:99999:7::: > /etc/shadow

cp -f /home/work/openssh/etc/moduli /usr/etc/
cp -f /home/work/openssh/etc/ssh_config /usr/etc/
cp -f /home/work/openssh/etc/sshd_config /usr/etc/
cp -f /home/work/openssh/etc/ssh_host_* /usr/etc/
chmod 700 /usr/etc/ssh_host_*

/home/work/openssh/sbin/sshd
echo "start sshd"


