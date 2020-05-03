# c-libp2p
Implementation of libp2p in C.

## build

* prepare installed

|     name    |  version  | 
| ----------- |-----------| 
| camke       |  3.15     | 

* clone from github

```
> git clone https://github.com/Holt666/c-libp2p
> git submodule init
> git submodule update
```
or

```
> git clone --recursive https://github.com/Holt666/c-libp2p
```

* use cmake build

```
> mkdir build & cd build
> cmake ..
> make
```

* run demo

```
> ./libp2p-demo
> libp2p node start listening ip:127.0.0.1, port:1234
```