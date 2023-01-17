# Below chunk was given to diagnose issues with a LAG failing
diag switch physical-ports linerate up
diag switch trunk summary
diag switch physical-ports summary
diag switch physical-ports port-stats list
diag debug report
show full
execute log display
# 
get switch modules summary 
get switch modules status
config switch phsyical-ports
edit port49
show full
set status down
end
edit port49
set status up
end
di swith physical-ports linerate port49
