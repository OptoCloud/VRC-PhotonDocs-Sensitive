/*
ImHex pattern for Event 7
*/

#include <std/io.pat>
#include <std/ptr.pat>
#include <std/mem.pat>

fn GetVTableOffset(u128 addr) {
	u8 tableOffset = std::mem::read_unsigned(addr, 1);
	s16 vTableOffset = 0 - s16(std::mem::read_unsigned(addr + tableOffset, 1));
	s16 totalOffset = tableOffset + vTableOffset;
	return totalOffset;
};

u32 currIndex;
struct FbsVectorEntry {
	u8 data[2];
};

struct FbsVector {
	u8 size;
	FbsVectorEntry entries[size];
};

struct FbsTableEntryPtr {
	if (std::mem::read_unsigned($, 1) != 0)
	{
		FbsVector* entryPtr : u8 [[pointer_base("std::ptr::relative_to_pointer")]];
	} else {
		u8 nullptr;
	}
};

struct FbsTable {
	u8 tableOffset;
	if (tableOffset == 5) {
		padding[GetVTableOffset($-1) - 1];
		u8 vTableSize;
		std::print("EntryCount: {}", vTableSize - 2);
		u8 tableDataSize;
		FbsTableEntryPtr entries[vTableSize - 2];
		u8 vTableOffset;
	} else {
		std::print("Unusual buffer!");
	}
};

struct Packet {
	u32 viewId;
	u32 serverTime;
	std::print("ViewID:     {}\nServerTime: {}\n", viewId, serverTime);
	FbsTable table;
};


Packet packet @ 0x00;
