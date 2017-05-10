Free-play Sandbox -- Web interface for experiment control
=========================================================

*This is one of the sister repository to  [the
ROS](https://github.com/severin-lemaignan/freeplay-sandbox-ros) and [the
QtQuick-based GUI](https://github.com/severin-lemaignan/freeplay-sandbox-qt) of
the 'Free-play Sandbox' experimental framework for Cognitive Human-Robot
Interaction research.*

This repository contains a CGI server and a web interface to control the
Free-play sandox experiment: start/stop nodes; manipulation of the QtQuick
interface; recording of participants.

The web interface is made of **a FastCGI server** to bridge ROS with a web
application, and a HTML GUI that allow the experimenter to control the
experiment from a web browser.


Installation
------------

First, install [the ROS](https://github.com/severin-lemaignan/freeplay-sandbox-ros) and [QtQuick-based GUI](https://github.com/severin-lemaignan/freeplay-sandbox-qt).


Then, install the dependencies (and a web-server):

```
> sudo apt install python-flup python-jinja2 nginx
```

Then:

```
> git clone https://github.com/severin-lemaignan/freeplay-sandbox-supervisor.git
> cd freeplay-sandbox-supervisor
> mkdir build && cd build
> cmake -DCMAKE_BUILD_TYPE=Release ..
> make install
```

Finally, configure your webserver. Assuming `nginx`:

```
> sudo cp share/nginx.conf /etc/nginx/sites-enabled/freeplay_sandbox_supervisor
> sudo service nginx restart
```

(you might want to change the configuration to use a different port -- 80 by
default)

Usage
-----

```
> rosrun freeplay_sandbox_supervisor supervisor
```

Then point a webbrowser to your server. For instance, locally: `http://localhost:80`


