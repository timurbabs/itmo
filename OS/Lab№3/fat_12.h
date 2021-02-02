#ifndef LAB_3_FAT12_H
#define LAB_3_FAT12_H

class fat_12 {
private:
    std::vector <uint8_t> BS_jmpBoot = {0xEB, 0x3E, 0x90};
    std::vector <uint8_t> BS_OEMName = {'b', 'o', 'l', 'g', 'e', 'n', 'o', 's'};
    uint16_t BPB_BytsPerSec;
    uint8_t BPB_SecPerClus;
    uint16_t BPB_RsvdSecCnt = 1;
    uint8_t BPB_NumFATs;
    uint16_t BPB_RootEntCnt;
    uint16_t BPB_TotSec16;
    uint8_t BPB_Media = 0xF8;
    uint16_t BPB_FATSz16;
    uint16_t BPB_SecPerTrk = 0x80;
    uint16_t BPB_NumHeads = 0x66;
    uint32_t BPB_HiddSec = 0;
    uint32_t BPB_TotSec32;

    uint8_t BS_DrvNum = 0x80;
    uint8_t BS_Reserved1 = 0;
    uint8_t BS_BootSig = 0x29;
    uint32_t BS_VolID = 1488228;
    std::vector <uint8_t> BS_VolLab = {'N', 'O', 'N', 'A', 'M', 'E', ' ', ' ', ' ', ' ', ' '};
    std::vector <uint8_t> BS_FilSysType = {'=', '3', '=', '3', '=', '3', '!', '!'};
    std::vector <uint8_t> BootProgram = {0x0E, 0x1F, 0xBE, 0x5B, 0x7C, 0xAC, 0x22, 0xC0, 0x74, 0x0B, 0x56, 0xB4, 0x0E,
                                         0xBB, 0x07, 0x00, 0xCD, 0x10, 0x5E, 0xEB, 0xF0, 0x32, 0xE4, 0xCD, 0x16, 0xCD,
                                         0x19, 0xEB, 0xFE, 0x54, 0x68, 0x69, 0x73, 0x20, 0x69, 0x73, 0x20, 0x6E, 0x6F,
                                         0x74, 0x20, 0x61, 0x20, 0x62, 0x6F, 0x6F, 0x74, 0x61, 0x62, 0x6C, 0x65, 0x20,
                                         0x64, 0x69, 0x73, 0x6B, 0x2E, 0x20, 0x20, 0x50, 0x6C, 0x65, 0x61, 0x73, 0x65,
                                         0x20, 0x69, 0x6E, 0x73, 0x65, 0x72, 0x74, 0x20, 0x61, 0x20, 0x62, 0x6F, 0x6F,
                                         0x74, 0x61, 0x62, 0x6C, 0x65, 0x20, 0x66, 0x6C, 0x6F, 0x70, 0x70, 0x79, 0x20,
                                         0x61, 0x6E, 0x64, 0x0D, 0x0A, 0x70, 0x72, 0x65, 0x73, 0x73, 0x20, 0x61, 0x6E,
                                         0x79, 0x20, 0x6B, 0x65, 0x79, 0x20, 0x74, 0x6F, 0x20, 0x74, 0x72, 0x79, 0x20,
                                         0x61, 0x67, 0x61, 0x69, 0x6E, 0x20, 0x2E, 0x2E, 0x2E, 0x20, 0x0D, 0x0A, 0x00};

    unsigned RootDirSectors;
    FILE *vhd = nullptr;

public:
    fat_12(
            std::string BS_OEMName = "bolgenos",
            uint16_t BPB_BytsPerSec = 512,
            uint8_t BPB_SecPerClus = 4,
            uint8_t BPB_NumFATs = 2,
            uint16_t BPB_RootEntCnt = 512,
            uint32_t BPB_TotSec = 8000,
            uint16_t BPB_FATSz = 8,
            uint32_t BS_VolID = 1488228,
            std::string BS_VolLab = "NONAME     "
    ) {
        if (BS_OEMName.size() > 8) {
            throw ConstructorException("BS_OEMName can only be up to 8 chars");
        }
        for (short i = 0; i < 8; i++) {
            this->BS_OEMName[i] = i < BS_OEMName.size() ? BS_OEMName[i] : 0x20;
        }

        if (BPB_BytsPerSec != 512 && BPB_BytsPerSec != 1024 && BPB_BytsPerSec != 2048 && BPB_BytsPerSec != 4096) {
            throw ConstructorException("BPB_BytsPerSec can only be 512, 1024, 2048, or 4096");
        }

        this->BPB_BytsPerSec = BPB_BytsPerSec;

        if (BPB_SecPerClus != 1 && BPB_SecPerClus != 2 && BPB_SecPerClus != 4 && BPB_SecPerClus != 8 &&
            BPB_SecPerClus != 16 && BPB_SecPerClus != 32 && BPB_SecPerClus != 64 && BPB_SecPerClus != 128) {
            throw ConstructorException("BPB_SecPerClus can only be 1, 2, 4, 8, 16, 32, 64, or 128");
        }

        this->BPB_SecPerClus = BPB_SecPerClus;
        this->BPB_NumFATs = BPB_NumFATs;
        this->BPB_RootEntCnt = BPB_RootEntCnt;

        if (BPB_TotSec & 0xFFFFFFFF00000000) {
            this->BPB_TotSec16 = 0;
            this->BPB_TotSec32 = BPB_TotSec;
        } else {
            this->BPB_TotSec16 = BPB_TotSec;
            this->BPB_TotSec32 = 0;
        }

        this->BPB_FATSz16 = BPB_FATSz;

        this->RootDirSectors = ((this->BPB_RootEntCnt * 32) + (this->BPB_BytsPerSec - 1)) / this->BPB_BytsPerSec;
        unsigned DataSec = BPB_TotSec - (BPB_RsvdSecCnt + (BPB_NumFATs * BPB_FATSz) + this->RootDirSectors);
        unsigned CountOfClusters = DataSec / BPB_SecPerClus;
        if (CountOfClusters > 4085) {
            throw ConstructorException("This is not FAT12\nTry more or less clusters");
        }

        if (BS_VolID == 1488228) {
            srand(time((nullptr)));
            this->BS_VolID = rand();
        } else {
            this->BS_VolID = BS_VolID;
        }

        if (BS_VolLab.size() > 11) {
            throw ConstructorException("BS_VolLab can only be up to 11 chars");
        }
        for (short i = 0; i < 11; i++) {
            this->BS_VolLab[i] = i < BS_VolLab.size() ? BS_VolLab[i] : 0x20;
        }
    }

    void printInt8(const uint8_t &n) {
        fputc((uint8_t)(n & 0xff), vhd);
    }

    void printInt16(const uint16_t &n) {
        fputc((uint8_t)(n & 0x00ff), vhd);
        fputc((uint8_t)((n & 0xff00) >> 8), vhd);
    }

    void printInt32(const uint32_t &n) {
        fputc((uint8_t)(n & 0x000000ff), vhd);
        fputc((uint8_t)((n & 0x0000ff00) >> 8), vhd);
        fputc((uint8_t)((n & 0x00ff0000) >> 16), vhd);
        fputc((uint8_t)((n & 0xff000000) >> 24), vhd);
    }

    uint8_t getInt8() {
        uint8_t value = 0;
        fread(&value, 1, 1, vhd);
        return value;
    }

    uint16_t getInt16() {
        uint16_t value = 0;
        fread(&value, 2, 1, vhd);
        return value;
    }

    uint16_t getInt12(bool left) {
        uint16_t value = getInt16();
        if (left) {
            value >>= 4;
        } else {
            value &= 0xFFF;
        }
        return value;
    }

    void printInt12(const uint16_t& n, bool left, int offset) {
        fseek(vhd, offset, SEEK_SET);
        uint16_t value = getInt16();
        if (left) {
            value = (n << 4) | (value & 0xF);
        } else {
            value = (n & 0xF000) | (value & 0xFFF);
        }
        fseek(vhd, offset, SEEK_SET);
        fputc((uint8_t)(n & 0x00ff), vhd);
        fputc((uint8_t)((n & 0xff00) >> 8), vhd);
    }

    uint32_t getInt32(int size = 4) {
        uint32_t value = 0;
        fread(&value, size, 1, vhd);
        return value;
    }

    void printString(const std::string &n) {
        for (unsigned char i : n) {
            fputc(i, vhd);
        }
    }

    void printVector(const std::vector <uint8_t> &n) {
        for (unsigned char i : n) {
            fputc(i, vhd);
        }
    }

    void print00(long long n) {
        for (int i = 0; i < n; i++) {
            fputc((uint8_t)(0x00), vhd);
        }
    }

    std::string getString(int length)
    {
        std::string temp(length, 0);
        fread(&temp[0], 1, length, vhd);
        return temp;
    }

    std::vector<uint8_t> getVector(int length)
    {
        std::string temps = getString(length);
        std::vector<uint8_t> temp(length);
        for (int i = 0; i < length; i++) {
            temp[i] = temps[i];
        }
        return temp;
    }


public:

    void bootFromFile(std::string imageName) {
        this->vhd = fopen(imageName.c_str(), "r+b");
        this->BS_jmpBoot = getVector(3);
        this->BS_OEMName = getVector(8);
        this->BPB_BytsPerSec = getInt16();
        this->BPB_SecPerClus = getInt8();
        this->BPB_RsvdSecCnt = getInt16();
        this->BPB_NumFATs = getInt8();
        this->BPB_RootEntCnt = getInt16();
        this->BPB_TotSec16 = getInt16();
        this->BPB_Media = getInt8();
        this->BPB_FATSz16 = getInt16();
        this->BPB_SecPerTrk = getInt16();
        this->BPB_NumHeads = getInt16();
        this->BPB_HiddSec = getInt32();
        this->BPB_TotSec32 = getInt32();

        this->BS_DrvNum = getInt8();
        this->BS_Reserved1 = getInt8();
        this->BS_BootSig = getInt8();
        this->BS_VolID = getInt32();
        this->BS_VolLab = getVector(11);
        this->BS_FilSysType = getVector(8);

        this->RootDirSectors = ((this->BPB_RootEntCnt * 32) + (this->BPB_BytsPerSec - 1)) / this->BPB_BytsPerSec;

    }

private:

    void printBootSector() {
        this->printVector(this->BS_jmpBoot);
        this->printVector(this->BS_OEMName);
        this->printInt16(this->BPB_BytsPerSec);
        this->printInt8(this->BPB_SecPerClus);
        this->printInt16(this->BPB_RsvdSecCnt);
        this->printInt8(this->BPB_NumFATs);
        this->printInt16(this->BPB_RootEntCnt);
        this->printInt16(this->BPB_TotSec16);
        this->printInt8(this->BPB_Media);
        this->printInt16(this->BPB_FATSz16);
        this->printInt16(this->BPB_SecPerTrk);
        this->printInt16(this->BPB_NumHeads);
        this->printInt32(this->BPB_HiddSec);
        this->printInt32(this->BPB_TotSec32);

        this->printInt8(this->BS_DrvNum);
        this->printInt8(this->BS_Reserved1);
        this->printInt8(this->BS_BootSig);
        this->printInt32(this->BS_VolID);
        this->printVector(this->BS_VolLab);
        this->printVector(this->BS_FilSysType);

        this->printVector(this->BootProgram);

        fseek(vhd, 510, SEEK_SET);
        fputc((uint8_t)0x55, vhd);
        fputc((uint8_t)0xAA, vhd);
    }

    void printReservedRegion() {
        this->printBootSector();
    }

    void printFatTable(int offset) {
        uint16_t freeCluster = 0x000, lastCluster = 0xFFF, reservedValue = 0xFF8;
        this->printInt12(reservedValue, true, offset);
        this->printInt12(lastCluster, false, offset+1);
    }

    void editFatTableCluster(int cluster, uint16_t value) {
        for (int i = 0; i < this->BPB_NumFATs; i++) {
            fseek(vhd, this->BPB_BytsPerSec * (i * this->BPB_FATSz16 + this->BPB_RsvdSecCnt)
                       + cluster * 2, SEEK_SET);
            int offset = this->BPB_BytsPerSec * (i * this->BPB_FATSz16 + this->BPB_RsvdSecCnt)
                         + int(cluster * 1.5);
            this->printInt12(value, !(cluster & 1), offset);
        }
    }

    int getNextCluster(int cluster) {
        fseek(vhd, this->BPB_BytsPerSec * BPB_RsvdSecCnt + int(cluster * 1.5), SEEK_SET);
        return getInt12(!(cluster & 1));
    }

    int getFreeCluster() {
        for (int cluster = 3; cluster < this->BPB_FATSz16 * this->BPB_BytsPerSec; cluster++) {
            fseek(vhd, this->BPB_BytsPerSec * BPB_RsvdSecCnt + int(cluster * 1.5), SEEK_SET);
            int clusterInfo = getInt12(!(cluster & 1));
            if (clusterInfo == 0x0000) {
                return cluster;
            }
        }
        throw FullDiskException("Disk is full, cannot find free cluster");
    }

    int getFreeClusterSpaceOffset(int cluster) {
        int freeClusterSpaceOffset = 0;
        if (cluster == 0) {
            for (int i = this->RootDirSectors * this->BPB_BytsPerSec - 32; i >= 0; i -= 32) {
                fseek(vhd, this->BPB_BytsPerSec * (BPB_NumFATs * this->BPB_FATSz16 + this->BPB_RsvdSecCnt)
                           + i, SEEK_SET);
                int x = getInt8();
                if (x != 0x00) {
                    if (i == this->RootDirSectors * this->BPB_BytsPerSec - 32) {
                        throw FullClusterException("Root Cluster is full");
                    }
                    break;
                }
                freeClusterSpaceOffset = i;
            }
        } else {
            for (int i = this->BPB_SecPerClus * this->BPB_BytsPerSec - 32; i >= 0; i -= 32) {
                fseek(vhd, this->BPB_BytsPerSec * (BPB_NumFATs * this->BPB_FATSz16 + this->BPB_RsvdSecCnt)
                           + (this->RootDirSectors * this->BPB_BytsPerSec)
                           + (this->BPB_BytsPerSec * (cluster - 2) * this->BPB_SecPerClus)
                           + i, SEEK_SET);
                int x = getInt8();
                if (x != 0x00) {
                    if (i == this->BPB_SecPerClus * this->BPB_BytsPerSec - 32) {
                        throw FullClusterException("Cluster is full");
                    }
                    break;
                }
                freeClusterSpaceOffset = i;
            }
        }
        return freeClusterSpaceOffset;
    }

    std::string getNewNumberOfFileWithPrefix(const std::string& prefix, int firstCluster) {
        //prefix should ends with ~
        int maxNumberWithPrefix = 0;
        if (firstCluster == 0) {
            for (int i = 0; i < this->RootDirSectors * BPB_BytsPerSec; i += 32) {
                fseek(vhd, this->BPB_BytsPerSec * (BPB_NumFATs * this->BPB_FATSz16 + this->BPB_RsvdSecCnt)
                           + i + 26, SEEK_SET);
                int entityFirstCluster = getInt16();
                if (entityFirstCluster == 0) {
                    continue;
                }

                fseek(vhd, this->BPB_BytsPerSec * (BPB_NumFATs * this->BPB_FATSz16 + this->BPB_RsvdSecCnt)
                           + i, SEEK_SET);
                std::string entityPrefix = getString(prefix.length());
                if (entityPrefix == prefix) {
                    fseek(vhd, this->BPB_BytsPerSec * (BPB_NumFATs * this->BPB_FATSz16 + this->BPB_RsvdSecCnt)
                               + i + prefix.length(), SEEK_SET);
                    std::string entityNumber = getString(8 - prefix.length());
                    int entityNumber_ = std::stoi(entityNumber);
                    maxNumberWithPrefix = std::max(maxNumberWithPrefix, entityNumber_);
                }
            }
        } else {
            int curCluster = firstCluster;
            while (curCluster != 0xfff) {
                for (int i = 0; i < BPB_SecPerClus * BPB_BytsPerSec; i += 32) {
                    fseek(vhd, this->BPB_BytsPerSec * (BPB_NumFATs * this->BPB_FATSz16 + this->BPB_RsvdSecCnt)
                               + (this->RootDirSectors * this->BPB_BytsPerSec)
                               + (this->BPB_BytsPerSec * (curCluster - 2) * this->BPB_SecPerClus)
                               + i + 26, SEEK_SET);
                    int entityFirstCluster = getInt16();
                    if (entityFirstCluster == 0) {
                        continue;
                    }

                    fseek(vhd, this->BPB_BytsPerSec * (BPB_NumFATs * this->BPB_FATSz16 + this->BPB_RsvdSecCnt)
                               + (this->BPB_BytsPerSec * this->RootDirSectors)
                               + (this->BPB_BytsPerSec * (curCluster - 2) * this->BPB_SecPerClus)
                               + i + 0, SEEK_SET);
                    std::string entityPrefix = getString(prefix.length());
                    if (entityPrefix == prefix) {
                        fseek(vhd, this->BPB_BytsPerSec * (BPB_NumFATs * this->BPB_FATSz16 + this->BPB_RsvdSecCnt)
                                   + (this->BPB_BytsPerSec * this->RootDirSectors)
                                   + (this->BPB_BytsPerSec * (curCluster - 2) * this->BPB_SecPerClus)
                                   + i + prefix.length(), SEEK_SET);
                        std::string entityNumber = getString(8 - prefix.length());
                        int entityNumber_ = std::stoi(entityNumber);
                        maxNumberWithPrefix = std::max(maxNumberWithPrefix, entityNumber_);
                    }
                }
                curCluster = getNextCluster(curCluster);
            }
        }
        int nextNumberWithPrefix = maxNumberWithPrefix + 1;
        std::string nextNumber = std::to_string(nextNumberWithPrefix);
        if (nextNumber.length() + prefix.length() > 8) {
            throw CreateFileException("Cannot create file with prefix " + prefix + ". Limit reached");
        }
        return nextNumber;
    }

    std::string getShortName(const std::string& filename, int firstCluster) {
        if (filename == ".") {
            return ".       ";
        } else if (filename == "..") {
            return "..      ";
        }
        for (int i = std::min(7, int(filename.length() + 1)); i >= 2; i++) {
            std::string prefix = filename.substr(0, i - 1) + "~";
            for (char & j : prefix) {
                if (j >= 'a' && j <= 'z') {
                    j -= 'a' - 'A';
                }
            }
            try {
                std::string number = getNewNumberOfFileWithPrefix(prefix, firstCluster);
                return prefix + number;
            } catch (CreateFileException& e) {
            }
        }
        throw CreateFileException("Cannot create file with name " + filename);
    }

    unsigned char getCheckSum(std::string shortName) {
        unsigned char sum = 0;
        int curChar = 0;
        for (int i = 11; i; i--) {
            sum = ((sum & 1) << 7) + (sum >> 1) + shortName[curChar++];
        }

        return sum;
    }

    std::string getFullName(const std::string& filename, int firstCluster, uint8_t attributes, uint16_t dataFirstCluster, uint32_t size) {
        std::vector<std::vector<uint8_t>> name(1, std::vector<uint8_t>(32, 0));
        int dotPos = filename.rfind('.');
        if (dotPos == std::string::npos) {
            dotPos = filename.length();
        }
        std::string filenameWithoutExtension = filename.substr(0, dotPos);
        std::string shortName;
        if (filename == "." || filename == "..") {
            shortName = filename;
        } else {
            shortName = getShortName(filenameWithoutExtension, firstCluster);
        }
        while (shortName.length() < 8) {
            shortName += char(0x20);
        }
        for (int i = dotPos + 1; i < std::min(dotPos + 4, int(filename.length())); i++) {
            if (filename[i] >= 'a' && filename[i] <= 'z') {
                shortName += char(filename[i] - 'a' + 'A');
            } else {
                shortName += filename[i];
            }
        }

        while (shortName.length() < 11) {
            shortName += char(0x20);
        }

        for (int i = 0; i < shortName.length(); i++) {
            name[0][i] = shortName[i];
        }

        name[0][11] = attributes;
//        1 byte DIR ATTR (readonly, hidden, system, volume_id, dir, arch)

//        1 byre RSVD

//        1 byte milliseconds

//        2 bytes time created

//        2 bytes date created

//        2 bytes date last access

//        2 bytes high bytes first cluster

//        2 bytes time last write

//        2 bytes date last write

        name[0][26] = dataFirstCluster & 0x00FF;
        name[0][27] = (dataFirstCluster & 0xFF00) >> 8;
//        2 bytes low bytes first cluster

//        4 bytes size
        name[0][28] = size & 0x000000FF;
        name[0][29] = (size & 0x0000FF00) >> 8;
        name[0][30] = (size & 0x00FF0000) >> 16;
        name[0][31] = (size & 0xFF000000) >> 24;


        ///generating long name
        if (filename != "." && filename != "..") {
            uint8_t checkSum = getCheckSum(shortName);
            for (int i = 0; i < filename.length(); i += 13) {
                name.emplace_back(std::vector<uint8_t>(32, 0));
                name.back()[0] = (i / 13) + 1;
                for (int j = i; j < i + 5; j++) {
                    name.back()[((j - i) << 1) + 1] = j < filename.length() ? filename[j] : 0xFF;
                    name.back()[((j - i) << 1) + 2] = j < filename.length() ? 0x00 : 0xFF;
                }
                name.back()[11] = 0x0f;
                name.back()[12] = 0x00;
                name.back()[13] = checkSum;
                for (int j = i + 5; j < i + 11; j++) {
                    name.back()[((j - i - 5) << 1) + 14] = j < filename.length() ? filename[j] : 0xFF;
                    name.back()[((j - i - 5) << 1) + 15] = j < filename.length() ? 0x00 : 0xFF;
                }

                for (int j = i + 11; j < i + 13; j++) {
                    name.back()[((j - i - 11) << 1) + 28] = j < filename.length() ? filename[j] : 0xFF;
                    name.back()[((j - i - 11) << 1) + 29] = j < filename.length() ? 0x00 : 0xFF;
                }
            }
            name.back()[0] += 0x40;
            std::reverse(name.begin(), name.end());
        }

        std::string fullName;
        for (auto& row : name) {
            for (auto& symbol : row) {
                fullName += symbol;
            }
        }
        return fullName;
    }

    int printFile(const std::string& filename, int firstCluster, uint8_t attributes, uint16_t dataFirstCluster, uint32_t size) {
        std::string fullName = getFullName(filename, firstCluster, attributes, dataFirstCluster, size);
        int cluster = firstCluster;

        int nameOffset = 0;
        int entSize = int(fullName.length() + 31) / 32;
        while (nameOffset < fullName.length()) {
            try {
                int offset = getFreeClusterSpaceOffset(cluster);
                if (this->BPB_SecPerClus * this->BPB_BytsPerSec - offset < fullName.length()) {
                    std::string partName = fullName.substr(nameOffset, this->BPB_SecPerClus * this->BPB_BytsPerSec - offset);
                    if (cluster == 0) {
                        fseek(vhd, this->BPB_BytsPerSec * (BPB_NumFATs * this->BPB_FATSz16 + this->BPB_RsvdSecCnt) + offset, SEEK_SET);
                    } else {
                        fseek(vhd, this->BPB_BytsPerSec * (BPB_NumFATs * this->BPB_FATSz16 + this->BPB_RsvdSecCnt)
                                   + (this->RootDirSectors * this->BPB_BytsPerSec)
                                   + (this->BPB_BytsPerSec * (cluster - 2) * this->BPB_SecPerClus)
                                   + offset, SEEK_SET);
                    }
                    printString(partName);
                    nameOffset += this->BPB_SecPerClus * this->BPB_BytsPerSec - offset;
                } else {
                    if (cluster == 0) {
                        fseek(vhd, this->BPB_BytsPerSec * (BPB_NumFATs * this->BPB_FATSz16 + this->BPB_RsvdSecCnt) + offset, SEEK_SET);
                    } else {
                        fseek(vhd, this->BPB_BytsPerSec * (BPB_NumFATs * this->BPB_FATSz16 + this->BPB_RsvdSecCnt)
                                   + (this->RootDirSectors * this->BPB_BytsPerSec)
                                   + (this->BPB_BytsPerSec * (cluster - 2) * this->BPB_SecPerClus)
                                   + offset, SEEK_SET);
                    }
                    printString(fullName);
                    nameOffset = fullName.length();
                    break;
                }
            } catch (FullClusterException& e) {
                if (cluster == 0) {
                    throw FullClusterException("Root is full");
                }
                cluster = getNextCluster(cluster);
                if (cluster == 0xFFF) {
                    int newCluster = getFreeCluster();

                    editFatTableCluster(cluster, newCluster);
                    editFatTableCluster(newCluster, 0xFFF);
                }
                continue;
            }
        }
        return entSize;
    }

    int printFileData(const std::string& path) {
        FILE* ptrFile = fopen(path.c_str() , "r+b");
        int clusterSize = this->BPB_BytsPerSec * this->BPB_SecPerClus;
        int prevCluster = -1;
        int firstCluster = -1, size = fs::file_size(path);
        if (ptrFile == nullptr) {
            throw CreateFileException("File not found");
        }

        for (int i = 0; i < size || i == 0; i += clusterSize) {
            std::vector<uint8_t> data(clusterSize);

            fread(&data[0], 1, clusterSize, ptrFile);
            int freeCluster = getFreeCluster();

            fseek(vhd, this->BPB_BytsPerSec * (BPB_NumFATs * this->BPB_FATSz16 + this->BPB_RsvdSecCnt)
                       + (this->RootDirSectors * this->BPB_BytsPerSec)
                       + (this->BPB_BytsPerSec * (freeCluster - 2) * this->BPB_SecPerClus), SEEK_SET);
            printVector(data);

            if (prevCluster != -1) {
                editFatTableCluster(prevCluster, freeCluster);
            }
            editFatTableCluster(freeCluster, 0xFFF);

            prevCluster = freeCluster;
            if (firstCluster == -1) {
                firstCluster = freeCluster;
            }
        }
        return firstCluster;
    }

    void printDirectoryContent(const std::string& path, int firstCluster, int parentCluster = -1) {
        int entCount = 0;
        int curCluster = firstCluster;
        if (parentCluster != -1) {
            entCount += printFile(".", firstCluster, 0x10, firstCluster, 0);
            entCount += printFile("..", firstCluster, 0x10, parentCluster, 0);
        }
        for (auto& entry : fs::directory_iterator(path)) {
            uint8_t attributes = 0;
            uint16_t dataFirstCluster = 0;
            uint32_t size = 0;
            if (fs::is_directory(entry.path())) {
                dataFirstCluster = getFreeCluster();
                editFatTableCluster(dataFirstCluster, 0xFFF);
                printDirectoryContent(entry.path(), dataFirstCluster, firstCluster);
                attributes |= 0x10;
            } else {
                dataFirstCluster = printFileData(entry.path());
                size = fs::file_size(entry.path());
            }
            std::string filepath = entry.path();
            std::string filename = filepath.substr(path.length() + 1) + char(0x00);
            entCount += printFile(filename, curCluster, attributes, dataFirstCluster, size);
            if (entCount * 32 == this->BPB_BytsPerSec * this->BPB_SecPerClus) {
                if (curCluster == 0) {
                    throw FullClusterException("Root cluster is full");
                }
                int newCluster = getFreeCluster();
                editFatTableCluster(curCluster, newCluster);
                editFatTableCluster(newCluster, 0xFFF);
            }
        }

    }

public:

    void printImage(std::string filename="b0lgenO5_FAT16.vhd", std::string pathToDir="") {
        this->vhd = fopen(filename.c_str(), "w+b");

        if (this->BPB_TotSec16 != 0) {
            print00(this->BPB_TotSec16 * this->BPB_BytsPerSec);
        } else {
            print00(this->BPB_TotSec32 * this->BPB_BytsPerSec);
        }

        fseek(vhd, 0, SEEK_SET);

        printReservedRegion();

        for (int i = 0; i < BPB_NumFATs; i++) {
            fseek(vhd, this->BPB_BytsPerSec * (this->BPB_FATSz16 * i + this->BPB_RsvdSecCnt), SEEK_SET);
            printFatTable(this->BPB_BytsPerSec * (this->BPB_FATSz16 * i + this->BPB_RsvdSecCnt));
        }

        if (!pathToDir.empty()) {
            printDirectoryContent(pathToDir, 0);
        }
    }

private:

    std::string getFileFullName(int cluster, int offset) {
        std::vector<std::vector<uint8_t>> name;
        if (cluster == 0) {
            while (true) {
                name.emplace_back(std::vector<uint8_t>(32, 0));
                fseek(vhd, this->BPB_BytsPerSec * (BPB_NumFATs * this->BPB_FATSz16 + this->BPB_RsvdSecCnt)
                           + offset, SEEK_SET);
                std::string namePart = getString(32);
                for (int i = 0; i < 32; i++) {
                    name.back()[i] = namePart[i];
                }
                if (name.back()[11] != 0x0F) {
                    reverse(name.begin(), name.end());
                    break;
                }
                offset += 32;
                if (offset == this->RootDirSectors * this->BPB_BytsPerSec) {
                    throw DirNotFoundException("Cursed directory");
                }
            }
        } else {
            while (true) {
                name.emplace_back(std::vector<uint8_t>(32, 0));
                fseek(vhd, this->BPB_BytsPerSec * (BPB_NumFATs * this->BPB_FATSz16 + this->BPB_RsvdSecCnt)
                           + (this->RootDirSectors * this->BPB_BytsPerSec)
                           + (this->BPB_BytsPerSec * (cluster - 2) * this->BPB_SecPerClus)
                           + offset, SEEK_SET);
                std::string namePart = getString(32);
                for (int i = 0; i < 32; i++) {
                    name.back()[i] = namePart[i];
                }
                if (name.back()[11] != 0x0F) {
                    reverse(name.begin(), name.end());
                    break;
                }
                offset += 32;
                if (offset == this->BPB_SecPerClus * this->BPB_BytsPerSec) {
                    cluster = getNextCluster(cluster);
                    if (cluster == 0xFFF) {
                        throw DirNotFoundException("Cursed Directory");
                    }
                }
            }
        }

        std::string filename;
        for (int i = 1; i < name.size(); i++) {
            for (int j = 1; j < 10; j += 2) {
                if (name[i][j] == 0x00) {
                    return filename;
                }
                filename += name[i][j];
            }
            for (int j = 14; j < 25; j += 2) {
                if (name[i][j] == 0x00) {
                    return filename;
                }
                filename += name[i][j];
            }
            for (int j = 28; j < 31; j += 2) {
                if (name[i][j] == 0x00) {
                    return filename;
                }
                filename += name[i][j];
            }
        }
        return filename;
    }

    int findClusterWithFileInDirectory(const std::string& name, int cluster) {
        if (cluster == 0) {
            for (int i = 0; i < this->BPB_BytsPerSec * this->RootDirSectors;) {
                std::string filename = getFileFullName(cluster, i);
                if (name == filename) {
                    i += (int(filename.length() + 1 + 12) / 13) * 32;
                    fseek(vhd, this->BPB_BytsPerSec * (BPB_NumFATs * this->BPB_FATSz16 + this->BPB_RsvdSecCnt)
                               + i + 26, SEEK_SET);
                    return getInt16();
                }
                i += (int(filename.length() + 1 + 12 + 13) / 13) * 32;
            }
        } else {
            for (int i = 0; i < this->BPB_BytsPerSec * this->BPB_SecPerClus; i += 32) {
                std::string filename = getFileFullName(cluster, i);
                if (name == filename) {

                    i += (int(filename.length() + 1 + 12) / 13) * 32;
                    fseek(vhd, this->BPB_BytsPerSec * (BPB_NumFATs * this->BPB_FATSz16 + this->BPB_RsvdSecCnt)
                               + (this->RootDirSectors * this->BPB_BytsPerSec)
                               + (this->BPB_BytsPerSec * (cluster - 2) * this->BPB_SecPerClus)
                               + i + 26, SEEK_SET);
                    return getInt16();
                }

                i += (int(filename.length() + 1 + 12 + 13) / 13) * 32;
            }
        }
        throw DirNotFoundException("Directory with name " + name + "not found");
    }

    int findClusterWithDirectory(const std::string& pathInside, int cluster = 0) {
        std::string buff;
        for (char i : pathInside) {
            if (i == '/' || i == '\\') {
                cluster = findClusterWithFileInDirectory(buff, cluster);
                buff.clear();
            } else {
                buff += i;
            }
        }
        return cluster;
    }

public:

    void copyInside(std::string pathToDir, std::string pathInside) {
        int clusterInside = findClusterWithDirectory(pathInside);
        printDirectoryContent(pathToDir, clusterInside);
    }

    std::string ls(std::string pathInside) {
        std::string ls;
        int clusterInside = findClusterWithDirectory(pathInside);

        if (clusterInside == 0) {
            int cluster = clusterInside;
            int offset = 0;
            while (cluster != 0xFFF) {

                fseek(vhd, this->BPB_BytsPerSec * (BPB_NumFATs * this->BPB_FATSz16 + this->BPB_RsvdSecCnt)
                           + offset, SEEK_SET);
                if (getInt8() == 0x00) {
                    return ls;
                }

                std::string filename = getFileFullName(cluster, offset);
                offset += (int(filename.length() + 1 + 12) / 13) * 32;
                if (offset > this->BPB_SecPerClus * this->BPB_BytsPerSec) {
                    throw CreateFileException("Cursed Root Directory");
                }

                fseek(vhd, this->BPB_BytsPerSec * (BPB_NumFATs * this->BPB_FATSz16 + this->BPB_RsvdSecCnt)
                           + offset + 11, SEEK_SET);

                uint8_t attributes = getInt8();
                std::string attributes_;
                if (attributes & 0x01) {
                    attributes_ += "readonly; ";
                }
                if (attributes & 0x02) {
                    attributes_ += "hidden; ";
                }
                if (attributes & 0x04) {
                    attributes_ += "system; ";
                }
                if (attributes & 0x08) {
                    attributes_ += "volume_id; ";
                }
                if (attributes & 0x10) {
                    attributes_ += "directory; ";
                }
                if (attributes & 0x20) {
                    attributes_ += "archive; ";
                }

                fseek(vhd, this->BPB_BytsPerSec * (BPB_NumFATs * this->BPB_FATSz16 + this->BPB_RsvdSecCnt)
                           + offset + 13, SEEK_SET);

                uint8_t createdMilliTime = getInt8();

                fseek(vhd, this->BPB_BytsPerSec * (BPB_NumFATs * this->BPB_FATSz16 + this->BPB_RsvdSecCnt)
                           + offset + 14, SEEK_SET);

                uint16_t createdTime = getInt16();
                std::string createdTime_;
                int hours = (createdTime & 0b111110000000000) >> 10;
                createdTime_ += std::to_string(hours);
                int minutes = (createdTime & 0b0000011111100000) >> 5;
                createdTime_ += ":" + std::to_string(minutes);
                int seconds = createdTime & 0b0000000000011111;
                seconds = seconds * 2 + createdMilliTime / 100;
                createdTime_ += ":" + std::to_string(seconds);
                createdTime_ += ":" + std::to_string(createdMilliTime % 100);

                fseek(vhd, this->BPB_BytsPerSec * (BPB_NumFATs * this->BPB_FATSz16 + this->BPB_RsvdSecCnt)
                           + offset + 16, SEEK_SET);

                uint16_t createdDate = getInt16();
                std::string createdDate_;

                int days = createdDate & 0b0000000000011111;
                createdDate_ += std::to_string(days);

                int months = (createdDate & 0b0000011111100000) >> 5;
                createdDate_ += "." + std::to_string(months);

                int years = (createdTime & 0b111110000000000) >> 10;
                createdDate_ += "." + std::to_string(years);
                //created time milliseconds 13 int8
                // created time 14 int16
                // created date 16 int16
                // last access date 18 int16
                // last modification time 22 int16
                // last modification date 24 int16
                fseek(vhd, this->BPB_BytsPerSec * (BPB_NumFATs * this->BPB_FATSz16 + this->BPB_RsvdSecCnt)
                           + offset + 28, SEEK_SET);
                int size = getInt32();

                ls += "Filename: " + filename + "; attributes: " + attributes_ + "; createdDateTime: " + createdDate_ +
                      " " + createdTime_ + "\n";

                offset += 32;

                if (offset == this->BPB_SecPerClus * this->BPB_BytsPerSec) {
                    return ls;
                }
            }
        } else {
            int cluster = clusterInside;
            int offset = 64;
            while (cluster != 0xFFF) {

                fseek(vhd, this->BPB_BytsPerSec * (BPB_NumFATs * this->BPB_FATSz16 + this->BPB_RsvdSecCnt)
                           + (this->RootDirSectors * this->BPB_BytsPerSec)
                           + (this->BPB_BytsPerSec * (cluster - 2) * this->BPB_SecPerClus)
                           + offset, SEEK_SET);
                if (getInt8() == 0x00) {
                    break;
                }

                std::string filename = getFileFullName(cluster, offset);
                offset += (int(filename.length() + 1 + 12) / 13) * 32;
                while (offset > this->BPB_SecPerClus * this->BPB_BytsPerSec) {
                    cluster = getNextCluster(cluster);
                    if (cluster == 0xFFF) {
                        throw CreateFileException("Cursed Directory");
                    }
                    offset -= this->BPB_SecPerClus * this->BPB_BytsPerSec;
                }

                fseek(vhd, this->BPB_BytsPerSec * (BPB_NumFATs * this->BPB_FATSz16 + this->BPB_RsvdSecCnt)
                           + (this->RootDirSectors * this->BPB_BytsPerSec)
                           + (this->BPB_BytsPerSec * (cluster - 2) * this->BPB_SecPerClus)
                           + offset + 11, SEEK_SET);

                uint8_t attributes = getInt8();
                std::string attributes_;
                if (attributes & 0x01) {
                    attributes_ += "readonly; ";
                }
                if (attributes & 0x02) {
                    attributes_ += "hidden; ";
                }
                if (attributes & 0x04) {
                    attributes_ += "system; ";
                }
                if (attributes & 0x08) {
                    attributes_ += "volume_id; ";
                }
                if (attributes & 0x10) {
                    attributes_ += "directory; ";
                }
                if (attributes & 0x20) {
                    attributes_ += "archive; ";
                }

                fseek(vhd, this->BPB_BytsPerSec * (BPB_NumFATs * this->BPB_FATSz16 + this->BPB_RsvdSecCnt)
                           + (this->RootDirSectors * this->BPB_BytsPerSec)
                           + (this->BPB_BytsPerSec * (cluster - 2) * this->BPB_SecPerClus)
                           + offset + 13, SEEK_SET);

                uint8_t createdMilliTime = getInt8();

                fseek(vhd, this->BPB_BytsPerSec * (BPB_NumFATs * this->BPB_FATSz16 + this->BPB_RsvdSecCnt)
                           + (this->RootDirSectors * this->BPB_BytsPerSec)
                           + (this->BPB_BytsPerSec * (cluster - 2) * this->BPB_SecPerClus)
                           + offset + 14, SEEK_SET);

                uint16_t createdTime = getInt16();
                std::string createdTime_;
                int hours = (createdTime & 0b111110000000000) >> 10;
                createdTime_ += std::to_string(hours);
                int minutes = (createdTime & 0b0000011111100000) >> 5;
                createdTime_ += ":" + std::to_string(minutes);
                int seconds = createdTime & 0b0000000000011111;
                seconds = seconds * 2 + createdMilliTime / 100;
                createdTime_ += ":" + std::to_string(seconds);
                createdTime_ += ":" + std::to_string(createdMilliTime % 100);

                fseek(vhd, this->BPB_BytsPerSec * (BPB_NumFATs * this->BPB_FATSz16 + this->BPB_RsvdSecCnt)
                           + (this->RootDirSectors * this->BPB_BytsPerSec)
                           + (this->BPB_BytsPerSec * (cluster - 2) * this->BPB_SecPerClus)
                           + offset + 16, SEEK_SET);

                uint16_t createdDate = getInt16();
                std::string createdDate_;

                int days = createdDate & 0b0000000000011111;
                createdDate_ += std::to_string(days);

                int months = (createdDate & 0b0000011111100000) >> 5;
                createdDate_ += "." + std::to_string(months);

                int years = (createdTime & 0b111110000000000) >> 10;
                createdDate_ += "." + std::to_string(years);
                //created time milliseconds 13 int8
                // created time 14 int16
                // created date 16 int16
                // last access date 18 int16
                // last modification time 22 int16
                // last modification date 24 int16
                fseek(vhd, this->BPB_BytsPerSec * (BPB_NumFATs * this->BPB_FATSz16 + this->BPB_RsvdSecCnt)
                           + (this->RootDirSectors * this->BPB_BytsPerSec)
                           + (this->BPB_BytsPerSec * (cluster - 2) * this->BPB_SecPerClus)
                           + offset + 28, SEEK_SET);
                int size = getInt32();

                ls += "Filename: " + filename + "; attributes: " + attributes_ + "; createdDateTime: " + createdDate_ + " " + createdTime_ + "\n";

                offset += 32;

                if (offset == this->BPB_SecPerClus * this->BPB_BytsPerSec) {
                    cluster = getNextCluster(cluster);
                    if (cluster == 0xFFF) {
                        break;
                    }
                    offset -= this->BPB_SecPerClus * this->BPB_BytsPerSec;
                }

            }
        }
        return ls;
    }

    void remove(std::string pathInside) {
        int clusterInside = findClusterWithDirectory(pathInside);

    }

    int getFreeClustersCount(){
        int count = 0;
        for (int cluster = 3; cluster < this->BPB_FATSz16 * this->BPB_BytsPerSec; cluster++) {
            fseek(vhd, this->BPB_BytsPerSec * BPB_RsvdSecCnt + cluster * 2, SEEK_SET);
            int clusterInfo = getInt16();
            if (clusterInfo == 0x0000) {
                count++;
            }
        }
        return count;
    }

    int getSlavedClustersCount(){
        int count = 0;
        for (int cluster = 3; cluster < this->BPB_FATSz16 * this->BPB_BytsPerSec; cluster++) {
            fseek(vhd, this->BPB_BytsPerSec * BPB_RsvdSecCnt + cluster * 2, SEEK_SET);
            int clusterInfo = getInt16();
            if (clusterInfo != 0x0000) {
                count++;
            }
        }
        return count;
    }
};


#endif //LAB_3_FAT12_H
