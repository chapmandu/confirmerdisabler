# Confirmer & Disabler for CFWheels 2.x

## Re-instates removed `confirm` and `disable` arguments

### Applies to:

* buttonTag() : disable
* buttonTo() : confirm | disable
* linkTo() : confirm
* submitTag() : disable

### Usage:
```
  buttonTag(disable=true);

  buttonTo(confirm="Are you sure?", disable=true);

  linkTo(confirm="Are you REALLY REALLY sure?");

  submitTag(disable=true);
```
