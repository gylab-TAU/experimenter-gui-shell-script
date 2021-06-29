#!/bin/sh
repository="https://github.com/gylab-TAU/experimenter-gui.git"
base_path="/home/srv_egozi/"
directory_name="/home/srv_egozi/experimenter-gui"

echo "copying service file to the correct folder.."
	if ! sudo cp /home/srv_egozi/experimenter-gui-shell-script/experimenter_gui_service.service /etc/systemd/system; then
		echo "could not move service file to the correct fodlder"
	else
		echo "successfully moced service file to the correct folder"
	fi

echo "killing existing service called experimenter_gui_service.service"...

if ! systemctl stop experimenter_gui_service.service; then
	echo "could not kill experimenter_gui_service.service"
else
	echo "successfully killed existing service"
fi

echo "The project: $repository will be cloned into $directory_name. if it exists it will be overridden"
if [ -d $directory_name ];then
	echo "removing folder..."
	if ! rm -Rf $directory_name; then
		echo "failed to remove directory $directory_name"
	else
		echo "directory removed successfully"
	fi
else
	echo "$directory_name not found"
fi

if ! cd $base_path; then
	echo "failed to enter $base_path"
else
	echo "entered $base_path"
fi

echo "cloning $repolisotry..."

if ! git clone $repository; then
	echo "failed to clone $repository"
else
	echo "cloned sycessfully"
fi

if ! cd $directory_name; then
	echo "failed to enter $directory_name"
else
	echo "entered $directory_name"
fi

echo "installing node_modules...."

if ! npm install; then
	echo "failed to install node_modules"
else
	echo "successfully downloaded node_modules"
fi

echo "starting build..."

if ! npm run build; then
	echo "failed to build the app"
else
	echo "build succeeded"
fi

echo "enabling experimenter_gui_service.service"

if ! systemctl enable experimenter_gui_service.service; then
	echo "failed to enable experimenter_gui_service.service"
else
	echo "successfully enabled experimenter_gui_service.service"
fi

if ! systemctl start experimenter_gui_service.service; then
	echo "failed to start experimenter_gui_service.service"
else
	echo "successfully started experimenter_gui_service.service"
fi

if ! npm prune; then
	echo "failed pruning dev dependencies"
else
	echo "successfully pruned dev dependencies"
fi

echo "removing src folder..."

if ! rm -Rf $directory_name/src; then
	echo "failed to remove src folder"
else
	echo "sucessfully removed src folder"
fi
echo "*** DONE! *** "
