usage() {
  echo "Usage: $0 {create|delete}"
}

check_args() {
  if (( "$#" != 1 && "$#" != 2 )); then
	usage
	exit 1
  fi
}

main() {
  check_args "$@"

  case "$1" in
	create)
	  create
	  ;;
	delete)
	  delete
	  ;;
	-h | --help)
	  usage
	  exit 0
	  ;;
	*)
	  usage "$@"
	  exit 1
	  ;;
  esac
}
