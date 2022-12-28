# Below chunk was given to diagnose issues with a LAG failing
diag switch physical-ports linerate up
diag switch trunk summary
diag switch physical=ports summary
diag switch physical-ports port-stats list
diag debug report
show full
execute log display
