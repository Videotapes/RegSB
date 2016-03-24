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

				until [ "$registers" -le 0 ]
				do
					echo "Enter the account name: "
					read -r account

					f1="diags"
					f2="orig"

					f1c=$account$f1
					f2c=$account$f2

					mkdir -v ~/Desktop/"$f1c" && mkdir -v ~/Desktop/"$f2c"

					if [ -s ~/Desktop/cleanuptemp.txt ]
						then
							echo "$f1c" >> ~/Desktop/cleanuptemp.txt && echo "$f2c" >> ~/Desktop/cleanuptemp.txt

						else
							echo "$f1c" > ~/Desktop/cleanuptemp.txt && echo "$f2c" >> ~/Desktop/cleanuptemp.txt
					fi

					diagnostics=$(ls -t ~/Downloads |grep .zip |head -1)

					echo "$diagnostics"

					mv -v ~/Downloads/"$diagnostics" ~/Desktop/"$f1c"

					unzip ~/Desktop/"$f1c"/"$diagnostics" -d ~/Desktop/"$f1c"
					((registers--))
				done
				;;

			swap)

				echo "This does nothing right now; stop doing it"
				;;

			cleanup)

				echo "Deconstructing desktop setup."

				while read -r directory
				do
					rm -rfv "$directory"
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
