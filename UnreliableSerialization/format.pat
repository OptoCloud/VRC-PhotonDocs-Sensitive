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

struct ColorRGBA {
    float a;
    float b;
    float g;
    float r;
};
struct Color32 {
    s8 a;
    s8 b;
    s8 g;
    s8 r;
};
struct Vec3 {
    float z;
    float y;
    float x;
};
struct Vec4 {
    float w;
    float z;
    float y;
    float x;
};
struct Quaternion {
    float w;
    float z;
    float y;
    float x;
};
bitfield Quaternion_P8 {
    x : 8;
    y : 8;
    z : 8;
    w : 8;
};
bitfield Quaternion_P10 {
    x : 10;
    y : 10;
    z : 10;
    w : 10;
};
bitfield Quaternion_P12 {
    x : 12;
    y : 12;
    z : 12;
    w : 12;
};


struct VRC_SyncPhysics {
	u8 flags;
	padding[3];
	Vec3 position;
	Quaternion_P10 rotation;
	padding[3];
};
struct VRC_PlayerNet {
    u16 ping; // 0-35565
    u8 pingVarience; // 0-255
    u8 approxDeltaTime; // 0-266
    u8 qualityCounter; // iterates for every playernet sent
	padding[1];
};
struct VRC_AvatarParameters {
    u8 parameterValues[16]; // avatar parameter values
    u8 channelId[4]; // id of the avatar channel
    u8 channelType; // Bitfield of what channels are floats
    u8 channelMask; // Bitfield of what channels are active
};

struct FbsVectorEntry {
	std::print("\t\t\tIndex {}:", GetCurrVecIndex());
	if (GetCurrVecIndex() == 0) {
		std::print("\t\t\t\tSyncPhysics");
		VRC_SyncPhysics syncPhysics [[inline]];
	} else if (GetCurrVecIndex() == 1) {
		std::print("\t\t\t\tSyncPhysics");
		VRC_SyncPhysics syncPhysics [[inline]];
	} else if (GetCurrVecIndex() == 2) {
		std::print("\t\t\t\tSyncPhysics");
		VRC_SyncPhysics syncPhysics [[inline]];
	} else if (GetCurrVecIndex() == 3) {
		std::print("\t\t\t\tSyncPhysics");
		VRC_PlayerNet playerNet [[inline]];
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
