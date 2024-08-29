#!/bin/sh

if [ -n "$DESTDIR" ] ; then
    case $DESTDIR in
        /*) # ok
            ;;
        *)
            /bin/echo "DESTDIR argument must be absolute... "
            /bin/echo "otherwise python's distutils will bork things."
            exit 1
    esac
fi

echo_and_run() { echo "+ $@" ; "$@" ; }

echo_and_run cd "/home/pranav/irocu/src/diff_drive"

# ensure that Python install destination exists
echo_and_run mkdir -p "$DESTDIR/home/pranav/irocu/install/lib/python3/dist-packages"

# Note that PYTHONPATH is pulled from the environment to support installing
# into one location when some dependencies were installed in another
# location, #123.
echo_and_run /usr/bin/env \
    PYTHONPATH="/home/pranav/irocu/install/lib/python3/dist-packages:/home/pranav/irocu/build/lib/python3/dist-packages:$PYTHONPATH" \
    CATKIN_BINARY_DIR="/home/pranav/irocu/build" \
    "/usr/bin/python3" \
    "/home/pranav/irocu/src/diff_drive/setup.py" \
     \
    build --build-base "/home/pranav/irocu/build/diff_drive" \
    install \
    --root="${DESTDIR-/}" \
    --install-layout=deb --prefix="/home/pranav/irocu/install" --install-scripts="/home/pranav/irocu/install/bin"
