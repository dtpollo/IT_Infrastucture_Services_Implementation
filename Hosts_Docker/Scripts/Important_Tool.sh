#!/usr/bin/bash
# Daniel Troya

# Create the main menu with different options
echo "Hey dude! Choose one :)"
echo "1) User and Group Management"
echo "2) File Permission Configuration"
echo "3) Exit"
read op

# We split the script into functions so it's easier to understand.
# First we define the functions, and then we call them in the main execution.

# ====> Option 1 <====

# This function creates a user or a group. If the option is invalid, it shows an error message.
add_usser_or_group(){
    echo "1) User"
    echo "2) Group"
    read addchoice
    case $addchoice in
        1) 
            read -p "Enter username: " name
            sudo adduser $name
            echo "$name user created"
            ;;
        2) 
            read -p "Enter groupname: " name
            sudo groupadd $name
            echo "$name group created"
            ;; 
        *) 
            echo "Error: Wrong option"
            ;;
    esac
}

# This function adds a user to a specific group.
Modify(){
    read -p "Enter username: " uname
    read -p "Enter groupname: " gname
    sudo usermod -g $uname $gname
    echo "$uname added to $gname"
}

# This function deletes a user or a group. If the choice is invalid, it shows an error.
Delete(){
    echo "1) User"
    echo "2) Group"
    read addchoice
    case $addchoice in
        1) 
            read -p "Enter username: " name
            sudo userdel -r $name
            echo "$name deleted"
            ;;
        2) 
            read -p "Enter groupname: " name
            sudo groupdel $name
            echo "$name group deleted"
            ;; 
        *) 
            echo "Error: Wrong option"
            ;;
    esac
}

# ====> Option 2 <====

# This function asks for a file or folder and changes its permission (read/write/execute).
Chanperm(){
    read -p "Enter a file path: " pth
    read -p "Enter a permission number: " perm
    chmod $perm $pth
}

# This function changes the owner and group of a file or folder.
Chanowner(){
    read -p "Enter a file path: " pth
    read -p "Enter the owner: " owner
    read -p "Enter the group: " grp
    chown $owner:$grp $pth    
}

# MAIN FUNCTION
# Here we call all the functions based on the user’s choice, and show error messages for invalid input.
case $op in
    1)
        echo "1) Add a user or group"
        echo "2) Modify user group"
        echo "3) Delete a user or group"
        read c1
        case $c1 in
            1) add_usser_or_group ;;
            2) Modify ;;
            3) Delete ;;
            *) echo "Error: Wrong option" ;;
        esac
        ;;
    2)
        echo "1) Change file permissions"
        echo "2) Change file ownership"
        read c2
        case $c2 in
            1) Chanperm ;;
            2) Chanowner ;;
            *) echo "Error: Wrong option" ;;
        esac
        ;;
    3)
        exit 0
        ;;
    *)
        echo "Error: Invalid option"
        ;;
esac

