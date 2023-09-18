docker_show()
{
cat << 'EOF'
$ sudo docker ps -a
CONTAINER ID   IMAGE                    COMMAND                  CREATED          STATUS                        PORTS     NAMES
766e9f93eae1   getting-started          "docker-entrypoint.s…"   3 minutes ago    Exited (0) 3 minutes ago                awesome_zhukovsky
2b80dcf262ac   hello-world              "/hello"                 5 minutes ago    Exited (0) 5 minutes ago                sleepy_germain

sudo docker rm 766e9f93eae1

$ sudo docker images
REPOSITORY               TAG         IMAGE ID       CREATED         SIZE
node                     18-alpine   264f8646c2a6   5 days ago      173MB
docker/getting-started   latest      3e4394f6b72f   3 weeks ago     47MB
ubuntu                   latest      6b7dfa7e8fdb   5 weeks ago     77.8MB
hello-world              latest      feb5d9fea6a5   15 months ago   13.3kB

$ sudo docker rmi 264f8646c2a

# run poky in a container
# problem with the library path
$ #sudo docker run --rm -it -v /home/xxbykowm/containers:/workdir crops/poky --workdir=/workdir
# binaries will have the same PATH set to the loader in Host and Container
$ sudo docker run --rm -it -v `pwd`:`pwd` -w `pwd` crops/poky --workdir=/workdir

# add pokyuser to sudoers
$ sudo docker ps
CONTAINER ID   IMAGE             COMMAND                  CREATED              STATUS              PORTS     NAMES
6e05d1d743ba   crops/poky   "/usr/bin/distro-ent…"   About a minute ago   Up About a minute             pensive_borg
$ sudo docker exec -u 0 -it 6e05d1d743ba bash
root@6e05d1d743ba:/home/yoctouser# usermod -aG sudo pokyuser
root@6e05d1d743ba:/home/yoctouser# passwd pokyuser
$ sudo docker commit 3884cc7fcde9 crops/poky
EOF
}
echo "docker_show()"
