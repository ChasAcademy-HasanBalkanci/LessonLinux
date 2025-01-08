# Calculate the average of a series of numbers.
SCORE="0"
AVERAGE="0"
SUM="0"
NUM="0"

while true; do
  echo -n "Enter your score [0-100%] ('q' for quit): "
  read SCORE
  # or we can use one command instead of the command aboved
  # read -p "Enter your score [0-100%] ('q' for quit): " SCORE

  if [ "$SCORE" == "q" ]; then
    echo "Average rating: $AVERAGE%."
    break
  elif ! [[ "$SCORE" =~ ^[0-9]+$ ]]; then
    echo "Invalid input. Please enter a number between 0 and 100, or 'q' to quit."
  elif (("$SCORE" < "0")) || (("$SCORE" > "100")); then
    echo "Be serious. Common, try again: "
  else
    SUM=$((SUM + SCORE))
    NUM=$((NUM + 1))
    AVERAGE=$((SUM / NUM))
  fi
done

echo "Exiting"