# Endpoints

## Chores

- `GET /chores` - Returns all chores incl. the next estimated execution time per chore
- `GET /chores/{choreId}` - Returns details of the given chore
- `POST /chores/{choreId}/execute` - Tracks an execution of the given chore
- `POST /chores/executions/{executionId}/undo` - Undoes a chore execution
- `POST /chores/executions/calculate-next-assignments` - (Re)calculates all next user assignments of all chores
- `GET /chores/{choreId}/printlabel` - Prints the Grocycode label of the given chore on the configured label printer
- `POST /chores/{choreIdToKeep}/merge/{choreIdToRemove}` - Merges two chores into one
