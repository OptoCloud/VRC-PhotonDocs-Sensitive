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
struct VRC_DestructiblePlayer {
    float health;
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

struct PhotonPacket {
	s32 viewId;
	s32 serverTime;
	padding[2];
	u8 bunchCount;
	u8 bunchId;
	padding[3];
	u8 vTableSize;
	u8 vTable[vTableSize];
};

PhotonPacket packet @ 0x00;

VRC_SyncPhysics syncPhysics[2] @  0x14;
VRC_PlayerNet playerNet @ 0x44;
u8 unknown1[12] @ 0x49;
u8 unknown2[119] @ 0x55;
