# myTomorrowsAssignment
**Please do not consider it as final approach, there is always room to make it better**

## Approaches
There are lots of solutions that can be implemented to meet the requirements, and it depends on several factors like
application type, the way development team is working, the way company infra and applications need to be managed,
number of applications, number of developers and environments, time to deliver applications and other important points.

In this assignment I see 2 approaches:
- Helm centralization, Create a helm template for any type of applications.
- App type specific, Create helm template for a sepecific application type that can be used for other application with
same type

The approach that I followed is in between:
- we have a helm template that is not fully customized, but it's enough to be able to integrate it to applications.
- there are rooms to make it fully customizable, in this case we need to specify the application values on terraform level.

## Containerization
- for each application and repository read the README.md.
- Registry: find all images [here](https://github.com/hosein-yousefii?tab=packages)
