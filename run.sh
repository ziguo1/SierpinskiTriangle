#!/bin/bash
nodemon --signal SIGTERM --ext pde --exec processing-java --sketch=$PWD --run
