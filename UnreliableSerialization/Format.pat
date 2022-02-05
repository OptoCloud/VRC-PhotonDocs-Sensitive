/*
ImHex pattern for Event 7
*/

#include "..\Common\VRCTypes.pat"

#include <std/io.pat>
#include <std/ptr.pat>
#include <std/mem.pat>

fn GetVTableOffset(u128 addr) {
	u8 tableOffset = std::mem::read_unsigned(addr, 1);
	s16 vTableOffset = 0 - s16(std::mem::read_unsigned(addr + tableOffset, 1));
	s16 totalOffset = tableOffset + vTableOffset;
	return totalOffset;
};

u32 currVecIndex;
fn GetCurrVecIndex() {
	return currVecIndex;
};
fn IncCurrVecIndex() {
	currVecIndex += 1;
};
fn ResetCurrVecIndex() {
	currVecIndex = 0;
};

u32 currTableEntry;
fn GetCurrTableEntry() {
	return currTableEntry;
};
fn IncCurrTableEntry() {
	currTableEntry += 1;
};
fn ResetCurrTableEntry() {
	currTableEntry = 0;
};

struct FbsVectorEntry {
	std::print("\t\t\tIndex {}:", GetCurrVecIndex());
	if (GetCurrVecIndex() == 0) {
		std::print("\t\t\t\tVECTOR!");
		u8 unknown[6];
	} else if (GetCurrVecIndex() == 1) {
		std::print("\t\t\t\tSyncPhysics");
		VRChat::SyncPhysics syncPhysics [[inline]];
	} else if (GetCurrVecIndex() == 2) {
		std::print("\t\t\t\tSyncPhysics");
		VRChat::SyncPhysics syncPhysics [[inline]];
	} else if (GetCurrVecIndex() == 3) {
		std::print("\t\t\t\tPlayerNet");
		VRChat::PlayerNet playerNet [[inline]];
	}
	IncCurrVecIndex();
};

struct FbsVector {
	u8 size;
	FbsVectorEntry entries[size];
	ResetCurrVecIndex();
};

struct FbsTableEntry {
	if (GetCurrTableEntry() == 1) {
		std::print("\t\tVector:");
		FbsVector vector [[inline]];
	}
};

struct FbsTableEntryPtr {
	std::print("\tEntry {}:", GetCurrTableEntry());
	if (std::mem::read_unsigned($, 1) != 0)
	{
		padding[std::mem::read_unsigned($, 1)];
		FbsTableEntry entry [[inline]];
	} else {
		u8 nullptr;
		std::print("\t\tNull");
	}
	IncCurrTableEntry();
};

struct FbsTable {
	u8 tableOffset;
	if (tableOffset == 5) {
		padding[GetVTableOffset($-1) - 1];
		u8 vTableSize;
		std::print("Entries:");
		u8 tableDataSize;
		FbsTableEntryPtr entries[vTableSize - 2];
		u8 vTableOffset;
	} else {
		std::print("Unusual buffer!");
	}
	ResetCurrTableEntry();
};

struct Packet {
	u32 viewId;
	u32 serverTime;
	std::print("ViewID:     {}\nServerTime: {}\n", viewId, serverTime);
	FbsTable table;
};


Packet packet @ 0x00;
