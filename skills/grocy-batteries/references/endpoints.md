# Endpoints

## Batteries

- `GET /batteries` - Returns all batteries incl. the next estimated charge time per battery
- `GET /batteries/{batteryId}` - Returns details of the given battery
- `POST /batteries/{batteryId}/charge` - Tracks a charge cycle of the given battery
- `POST /batteries/charge-cycles/{chargeCycleId}/undo` - Undoes a battery charge cycle
- `GET /batteries/{batteryId}/printlabel` - Prints the Grocycode label of the given battery on the configured label printer
