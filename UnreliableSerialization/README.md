# UnreliableSerialization (Event 7)


7 wizard bytes:
```cpp
05 // points to main table (including self)
  04 // size of this vtable (including self)
  02 // size of data pointed to by vtable
  00 // 1st entry in vtable (zero means no data)
  01 // 2nd entry in vtable (offset of one)
    04 // reverse pointer to vtable <------------------- main table starts here
    01 // offset to vector
      04 // length of vector
      45 // offset 1
      33 // offset 2
      1A // offset 3
      01 // offset 4
```
