# Sailings Finder

## Installation

- The application is dockerized so running `docker build -t sailings-finder .`
- to run the app `docker run -it sailings-finder`
- to test the app `docker compose exec app rspec`


## Usage

### Finding the cheapest direct ship between two destinations

```
CNSHA
NLRTM
cheapest-direct
```
it will return the cheapest direct ship between two ports, how is it done? we check if the origin and the destination of the sailings record matches with the input
no need to check for indirect, simple comparison.


### Finding the cheapest ship between two destinations

```
CNSHA
NLRTM
cheapest
```
it will return the cheapest ship between two ports, it is not necessary direct it could be multi legged shipment
How is it done? by building a graph to check all the possible routes between two points and compare the prices of the sailings


### Finding the fastest ship between two destinations

```
CNSHA
NLRTM
fastest
```
it will return the fastest ship between two ports, it is not necessary direct it could be multi legged shipment
How is it done? by checking the arrival date of the shippment and the one with the earliest date is the fastest

