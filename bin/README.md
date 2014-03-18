# Utilizing the Executables

You can view your _trips_ and _vehicles_ on the command line. This will give you a
quick table view.

## Examples

```
bundle exec bin/trips all
bundle exec bin/vehicles all
```

You may also **export** your trips to a CSV file with. You may pass it a
`filename` or it will be named `trips-{unix_timestamp}.csv`

```
bundle exec bin/trips export --filename 'my-file.csv'
```

# TODO

* Add more option flags for _sort_, _filter_, and _limits_
