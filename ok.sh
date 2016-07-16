#!/bin/bash

okdir="${PWD}/.ok"

if [ -z "${*}" ] # if no arguments supplied
then
    if [ -d "${okdir}" ] # if .ok dir exists
    then
        echo -e "\n$(tput setaf 2)Okay!$(tput sgr0)"
        echo -e "Showing available commands:"
        for cmd in ${okdir}/*
        do
            echo -e "\n$ $(tput setaf 6)ok $(basename "${cmd}" .sh)$(tput sgr0)"
            cat ${cmd}
        done
        exit 0
    else # if .ok dir doesn't exist
        echo -e "\n$(tput setaf 1)Not okay!$(tput sgr0)"
        echo "No $(tput setaf 6).ok$(tput sgr0) directory found."
        exit 1
    fi
else # if arguments supplied
    if [ -z "${2}" ] # if only one argument supplied
    then
        if [ "${1}" == "+" ] # if that argument is the add command
        then
            echo -e "\n$(tput setaf 1)Not okay!$(tput sgr0)"
            echo "Please give a name for the command to be added."
            exit 1
        elif [ "${1}" == "-" ] # if that argument is the remove command
        then
            echo -e "\n$(tput setaf 1)Not okay!$(tput sgr0)"
            echo "Please specify a command to be removed."
            exit 1
        elif [ "${1}" == "=" ] # if that argument is the show command
        then
            echo -e "\n$(tput setaf 1)Not okay!$(tput sgr0)"
            echo "Please specify a command to show."
            exit 1
        else # if that argument is anything else
            if [ -f "${okdir}/${1}.sh" ] # if the argument matches a command
            then
                echo -e "\n$(tput setaf 2)Okay!$(tput sgr0)"
                echo -e "I'm $(tput setaf 6)${1}$(tput sgr0)ing.\n"
                $SHELL "${okdir}/${1}.sh"
                exit 0
            else
                echo -e "\n$(tput setaf 1)Not okay!$(tput sgr0)"
                echo "$(tput setaf 6)${1}$(tput sgr0) is not a recognised command."
                exit 1
            fi
        fi
    elif [ -n "${3}" ] # if more than two arguments supplied
    then
        echo -e "\n$(tput setaf 1)Not okay!$(tput sgr0)"
        echo "One command at a time, please."
        exit 1
    else # if two arguments supplied
        if [ "${1}" == "+" ] || [ "${1}" == "-" ] # if the first argument is the add or the remove command
        then
            if [ "${2}" == "+" ] || [ "${2}" == "-" ] || [ "${2}" == "=" ] # if the second argument is a protected command
            then
                echo -e "\n$(tput setaf 1)Not okay!$(tput sgr0)"
                echo "$(tput setaf 6)${2}$(tput sgr0) is a protected command."
                exit 1
            else # if the second argument is not a protected command
                if [ "${1}" == "+" ] # if the first argument is the add command
                then
                    mkdir -p "${okdir}"
                    $EDITOR "${okdir}/${2}.sh"
                    exit 0
                else # if the first argument is the remove command
                    if [ -f "${okdir}/${2}.sh" ] # if the second argument is an extant command
                    then
                        read -p "Remove the $(tput setaf 6)${2}$(tput sgr0) command? [y/N] " -r
                        if [[ $REPLY =~ ^[Yy]$ ]] # if the user really wants to remove the command
                        then
                            echo -e "\n$(tput setaf 2)Okay!$(tput sgr0)"
                            echo -e "I'm removing the $(tput setaf 6)${2}$(tput sgr0) command."
                            rm -f "${okdir}/${2}.sh"
                            if [ ! "$(ls -A ${okdir})" ] # if there are no other commands saved
                            then
                                rmdir "${okdir}"
                            fi
                            exit 0
                        else # if the user actually wants to keep the command
                            echo -e "\n$(tput setaf 2)Okay!$(tput sgr0)"
                            echo -e "I'll leave the $(tput setaf 6)${2}$(tput sgr0) command be."
                            exit 0
                        fi
                    else # if the second argument is not an extant command
                        echo -e "\n$(tput setaf 1)Not okay!$(tput sgr0)"
                        echo "There is no $(tput setaf 6)${2}$(tput sgr0) command."
                        exit 1
                    fi
                fi
            fi
        elif [ "${1}" == "=" ] # if the first argument is the show command
        then
            if [ "${2}" == "+" ] # if the second argument is the add commmand
            then
                echo -e "\n$(tput setaf 2)Okay!$(tput sgr0)"
                echo -e "$ $(tput setaf 6)ok + {foo}$(tput sgr0) will add the $(tput setaf 6)foo$(tput sgr0) command if it doesn't exist, and edit it."
                exit 0
            elif [ "${2}" == "-" ] # if the second argument is the remove commmand
            then
                echo -e "\n$(tput setaf 2)Okay!$(tput sgr0)"
                echo -e "$ $(tput setaf 6)ok - {foo}$(tput sgr0) will remove the $(tput setaf 6)foo$(tput sgr0) command, if it exists."
                exit 0
            elif [ "${2}" == "=" ] # if the second argument is the show commmand
            then
                echo -e "\n$(tput setaf 2)Okay!$(tput sgr0)"
                echo -e "$ $(tput setaf 6)ok = {foo}$(tput sgr0) will explain what the $(tput setaf 6)foo$(tput sgr0) command does, if it exists."
                exit 0
            else
                if [ -f "${okdir}/${2}.sh" ] # if the second argument matches a command
                then
                    echo -e "\n$(tput setaf 2)Okay!$(tput sgr0)"
                    echo -e "Here's what happens when you tell me to $(tput setaf 6)${2}$(tput sgr0):\n"
                    cat "${okdir}/${2}.sh"
                    exit 0
                else
                    echo -e "\n$(tput setaf 1)Not okay!$(tput sgr0)"
                    echo "$(tput setaf 6)${2}$(tput sgr0) is not a recognised command."
                    exit 1
                fi
            fi
        else # if the first argument is not a protected command
            echo -e "\n$(tput setaf 1)Not okay!$(tput sgr0)"
            echo "One command at a time, please."
            exit 1
        fi
    fi
fi
exit 0
