#!/bin/bash
#this does the things

echo "Welcome to the script Stache made; it does the things"

PS3="++++Please select an action: "
select option in unpack swap cleanup kopps quit

do
		case $option in
			unpack)

				echo "Initiating desktop setup for diagnostics."
				if [ -e ~/Desktop/cleanuptemp.txt ]
					then
						echo "cleanuptemp.txt already exists; skipping generation."

					else
						echo "Creating cleanuptemp.txt."
						touch ~/Desktop/cleanuptemp.txt
				fi
				echo "How many registers are you setting up? "
				read -r registers

				until [ "$registers" -le 0 ]; do
					echo "Enter the account name: "
					read -r account

					Append_diag="diags"
					Append_container="cont"

					Diagnostics_folder=$account$Append_diag
					Container_folder=$account$Append_container

					mkdir -v ~/Desktop/"$Diagnostics_folder" && mkdir -v ~/Desktop/"$Container_folder"

					if [ -s ~/Desktop/cleanuptemp.txt ]
						then
							echo "$Diagnostics_folder" >> ~/Desktop/cleanuptemp.txt && echo "$Container_folder" >> ~/Desktop/cleanuptemp.txt

						else
							echo "$Diagnostics_folder" > ~/Desktop/cleanuptemp.txt && echo "$Container_folder" >> ~/Desktop/cleanuptemp.txt
					fi

					diagnostics=$(ls -t ~/Downloads |grep .zip |head -1)

					echo "$diagnostics"

					mv -v ~/Downloads/"$diagnostics" ~/Desktop/"$Diagnostics_folder"

					unzip ~/Desktop/"$Diagnostics_folder"/"$diagnostics" -d ~/Desktop/"$Diagnostics_folder"
					((registers--))
				done
				;;

			swap)

				echo "This does nothing right now; stop doing it"
				declare -a Diagnostics_folder_storage=()
				declare -a Container_folder_storage=()

				dfind="diags"

				while read -r directory ; do
  				if echo "$directory" | grep -q "$dfind"
  					then
    					Diagnostics_folder_storage=("${Diagnostics_folder_storage[@]}" "$directory")
    					#add to array diags
  					else
    					Container_folder_storage=("${Container_folder_storage[@]}" "$directory")
    					#add to array orig
  				fi
				done < ~/Desktop/cleanuptemp.txt
				echo ${Diagnostics_folder_storage[@]}
				echo "+++++++++++++++++++++++"
				echo ${Container_folder_storage[@]}

				;;

			cleanup)

				echo "Deconstructing desktop setup."

				while read -r directory
				do
					rm -rfv ~/Desktop/"$directory"
				done < ~/Desktop/cleanuptemp.txt

				rm -rfv ~/Desktop/cleanuptemp.txt
				;;

			kopps)

				echo "Not authorized; this command is Kopps Secret."
				;;

			quit)

				echo "Goodbye."

				break
				;;

		esac
		REPLY=
done
