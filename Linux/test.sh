#1
yum group install "Development Tools"
 
#2
tar -xvf bastet-0.43.tgz
cd bastet-0.43
yum install boost-devel boost ncurses-devel ncurses
make
 
# Добавить раздел install
#SOURCES=Ui.cpp main.cpp Block.cpp Well.cpp BlockPosition.cpp Config.cpp BlockChooser.cpp BastetBlockChooser.cpp
#PROGNAME=bastet
#LDFLAGS+=-lncurses
#CXXFLAGS+=-ggdb -Wall
#CXXFLAGS+=-DNDEBUG -Wall
#CXXFLAGS+=-pg
#LDFLAGS+=-pg
#
#all: $(PROGNAME)
#
#depend: *.hpp $(SOURCES)
#        $(CXX) -MM $(SOURCES) > depend
#
#include depend
#
#$(PROGNAME): $(SOURCES:.cpp=.o)
#        $(CXX) -ggdb -o $(PROGNAME) $(SOURCES:.cpp=.o) $(LDFLAGS) -lboost_program_options
#
#clean:
#        rm -f $(SOURCES:.cpp=.o) $(PROGNAME)
#
#mrproper: clean
#        rm -f *~
#
#install:
#        cp $(PROGNAME) /usr/bin/
#        chmod o+x /usr/bin/$(PROGNAME)
 
make install
 
#3
yum list installed > task3.log
 
#4
yum deplist gcc | grep "provider:" | awk '{print $2}' > task4_1.log
yum install yum-utils
repoquery -q --installed --whatrequires libgcc > task4_2.log
 
#5
mkdir localrepo && cd localrepo
yum install createrepo
createrepo ~/localrepo/
 
# Создаем файл /etc/yum.repos.d/localrepo.repo
#[localrepo]
#name=localrepo
#enabled=1
#gpgcheck=0
#baseurl=file:///root/localrepo/
 
yum update
 
#6
yum repolist > task6.log
 
#7
cd /etc/yum.repos.d/
mv localrepo.repo ..
rm -f *
mv ../localrepo.repo .
yum update
yum list available
yum install checkinstall
 
#8
alien -r fortunes-ru_1.52-2_all.deb
sudo rpm -i --replacefiles fortunes-ru-1.52-3.noarch.rpm
 
#9
wget https://www.nano-editor.org/dist/v5/nano-5.4.tar.xz
tar -xvf nano-5.4.tar.xz
cd nano-5.4
./configure --prefix=/usr/ --program-prefix=new
make
make install
