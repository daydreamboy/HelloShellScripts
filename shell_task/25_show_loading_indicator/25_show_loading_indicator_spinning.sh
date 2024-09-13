show_loading_while_exec()
{
  local -r pid="${1}"
  local -r msg="${2}"
  local -r delay='0.1'
  local -r loading_steps=("⢿" "⣻" "⣽" "⣾" "⣷" "⣯" "⣟" "⡿")
  local idx=0
  while ps a | awk '{print $1}' | grep -q "${pid}"; do

    printf " %s" "${loading_steps[idx]} ${msg}"

    idx=$(($idx + 1))
    idx=$(($idx % 8))

    printf "\r"
    sleep "${delay}"
  done

  green="\033[0;32m"
  endc="\033[0m"
  printf " %b" "${green}✔${endc} ${msg}\n"
}

sleep_command="sleep 5"
eval "${sleep_command} &"
show_loading_while_exec $! "Processing..."

{
  echo "sleeping 1 sec"
  sleep 1
  echo "sleeping 3 sec"
  sleep 3
  echo "sleeping 5 sec"
  sleep 5
}&
show_loading_while_exec $! "Processing again..."

{
  sleep 1
  sleep 3
  sleep 5
}&
show_loading_while_exec $! "Processing again and correct..."