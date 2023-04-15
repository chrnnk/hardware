if ([/system health get 1]> 50) do={[/system health set use-fan="main"]}
if ([/system health get 1]< 49) do={[/system health set use-fan="auxiliary"]}

:if ([/system health get 1]> 50) do={
  [/system health set use-fan="main"];
}
:if ([/system health get 1]< 49) do={
  [/system health set use-fan="auxiliary"];
}


:if (([/system health get 1]> 50) && ([/system health get use-fan]="auxiliary")) do={
  [/system health set use-fan="main"];
  log info "CPU is hot, switching to main fan";
}
:if (([/system health get 1]< 49) && ([/system health get use-fan]="main")) do={
  [/system health set use-fan="auxiliary"];
  log info "CPU is cool, switching to auxiliary fan";
}

