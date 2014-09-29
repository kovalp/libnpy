#!/usr/bin/env python
import numpy as np

n = 0; t = 0;
arr = np.load('fa.npy')
t=t+1; 
if arr.dtype!='float32': print "arr.dtype!='float32'"; n = n + 1
t=t+1; 
if any(arr!=[1,2,3,4]): print "arr!=[1,2,3,4]"; n = n + 1

arr = np.load("fb.npy")
t=t+1
if arr.dtype!='float32': print "arr.dtype!='float32'"; n = n + 1
t=t+1
if sum(sum(abs(arr-[[1,4],[2,5],[3,6]])))!=0 : print "sum(sum(abs(arr-[[ 1,4],[ 2,5],[ 3,6]])))!=0"; n = n + 1

arr = np.load("fc.npy")
t=t+1
if arr.dtype!='float64': print "arr.dtype!='float64'"; n = n + 1
t=t+1
if sum(sum(abs(arr-[[1,3,5],[2,4,6]])))!=0 : print "sum(sum(abs(arr-[[1,3,5],[2,4,6]])))!=0"; n = n + 1

arr = np.load("fd.npy")
t=t+1
if arr.dtype!='int32': print "arr.dtype!='int32'"; n = n + 1
t=t+1
if sum(sum(abs(arr-[[1,3,5,7,9],[2,4,6,8,10]])))!=0 : print "sum(sum(abs(arr-[[1,3,5,7,9],[2,4,6,8,10]])))!=0"; n = n + 1

arr = np.load("fe.npy")
t=t+1
if arr.dtype!='complex64': print "arr.dtype!='complex64'"; n = n + 1
t=t+1
if sum(sum(abs(arr-[[1+3j],[2+2j],[3+1j]])))!=0 : print "sum(sum(abs(arr-[[1+3j],[2+2j],[ 3+1j]])))!=0"; n = n + 1

arr = np.load("ff.npy")
t=t+1
if arr.dtype!='complex128': print "arr.dtype!='complex128'"; n = n + 1
t=t+1
if sum(abs(arr-[1+2j,2+1j]))!=0 : print "sum(abs(arr-[1+2j,2+1j]))!=0"; n = n + 1

if n==0 : 
  print "Everything seems to be fine." 
  print t, "tests passed."
else : 
  print n, " tests failed out of ", t
