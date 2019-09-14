# Rspec Pitfalls

## About time - 2019-10-14

- when there is `time difference`, e.g. `mynavi` is a Japanese project. We save time as `Tokyo`. When we construct the factory, when should us `Time.zone.parse()` to parse time first.
- when we the column in our database type is `time`, so there is always `2010-01-01 xx:xx:xx` when you save time to database. However, when we set its type as `datetime`, there are no problems.
- when set time `Time.zone.parse("07:00:00")` will become `2010-01-02 07:00:00`. However, set `Time.zone.parse("09:00:00")`, it will be `2010-01-01 09:00:00`
