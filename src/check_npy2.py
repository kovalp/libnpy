#!/usr/bin/env python
import numpy as np

n = 0; t = 0;
arr = np.load('a.npy')
t=t+1; 
if arr.dtype!='float64': print "arr.dtype!='float64'"; n = n + 1
t=t+1; 
if sum(sum(abs(arr-[[1,2,3], [4,5,6], [7,8,9]]))): print "a is wrong"; n = n + 1

arr = np.load("b.npy")
t=t+1
if arr.dtype!='float32': print "arr.dtype!='float32'"; n = n + 1
t=t+1
if sum(sum(abs(arr-[[0.5,1,1.5],[2,2.5,3]])))!=0 : print "b is wrong"; n = n + 1

arr = np.load("c.npy")
t=t+1
if arr.dtype!='int32': print "arr.dtype!='int32'"; n = n + 1
t=t+1
if sum(sum(abs(arr-[[1,2],[3,4],[5,6]])))!=0 : print "c is wrong"; n = n + 1

arr = np.load("d.npy")
t=t+1
if arr.dtype!='complex64': print "arr.dtype!='complex64'"; n = n + 1
t=t+1
if sum(abs(arr-[1+3j,2+2j,3+1j]))!=0 : print "d is wrong"; n = n + 1

arr = np.load("e.npy")
t=t+1
if arr.dtype!='complex128': print "arr.dtype!='complex128'"; n = n + 1
t=t+1
if sum(sum(abs(arr-[[ 1.+6.j,2.+5.j,3.+4.j],
	 [ 4.+3.j,5.+2.j,6.+1.j]])))!=0 : print "e is wrong"; n = n + 1



if n==0 : 
  print "Everything seems to be fine." 
  print t, "tests passed."
else : 
  print n, " tests failed out of ", t
