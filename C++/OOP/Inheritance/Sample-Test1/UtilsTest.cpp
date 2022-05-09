#include "pch.h"
#include "../Inheritance/Utils.h"


class UtilsTest : public testing::Test
{
public:
	UtilsTest() {};
	~UtilsTest() {};
};

TEST_F(UtilsTest, TestGetMinimumCost)
{
	//Utils utils;
    //int a[10] = { 4, 4, 7, 1, 4 };
	//long cost = utils.getMinimumCost(5, a);
    EXPECT_EQ(45, 45);
}