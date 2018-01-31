# encoding=utf-8
#
# by panda
# 抽象工厂模式


def printInfo(info):
    print unicode(info, 'utf-8')


# 抽象产品A：user表
class IUser():
    def Insert(self):
        pass

    def GetUser(self):
        pass


# sqlserver实现的User
class SqlserverUser(IUser):
    def Insert(self):
        printInfo("在SQL Server中给User表增加一条记录")

    def GetUser(self):
        printInfo("在SQL Server中得到User表的一条记录")


# Access实现的User
class AccessUser(IUser):
    def Insert(self):
        printInfo("在Access中给User表增加一条记录")

    def GetUser(self):
        printInfo("在Access中得到User表一条记录")


# 抽象产品B：部门表
class IDepartment():
    def Insert(self):
        pass

    def GetUser(self):
        pass


# sqlserver实现的Department
class SqlserverDepartment(IUser):
    def Insert(self):
        printInfo("在SQL Server中给Department表增加一条记录")

    def GetUser(self):
        printInfo("在SQL Server中得到Department表的一条记录")


# Access实现的Department
class AccessDepartment(IUser):
    def Insert(self):
        printInfo("在Access中给Department表增加一条记录")

    def GetUser(self):
        printInfo("在Access中得到Department表一条记录")


# 抽象工厂
class IFactory():
    def CreateUser(self):
        pass

    def CreateDepartment(self):
        pass

        # sql server工厂


class SqlServerFactory(IFactory):
    def CreateUser(self):
        return SqlserverUser()

    def CreateDepartment(self):
        return SqlserverDepartment()


# access工厂
class AccessFactory(IFactory):
    def CreateUser(self):
        return AccessUser()

    def CreateDepartment(self):
        return AccessDepartment()


# 优化一：采用一个简单工厂类，封装逻辑判断操作
class DataAccess():
    #    db = "Sqlserver"
    db = "Access"

    @staticmethod
    def CreateUser():
        if (DataAccess.db == "Sqlserver"):
            return SqlserverUser()
        elif (DataAccess.db == "Access"):
            return AccessUser()

    @staticmethod
    def CreateDepartment():
        if (DataAccess.db == "Sqlserver"):
            return SqlserverDepartment()
        elif (DataAccess.db == "Access"):
            return AccessDepartment()


# 优化二：采用反射机制，避免使用太多判断
##以下信息可以从配置文件中获取
DBType = 'Sqlserver'  # 'Access'
DBTab_User = 'User'
DBTab_Department = 'Department'


class DataAccessPro():
    #    db = "Sqlserver"
    db = "Access"

    @staticmethod
    def CreateUser():
        funName = DBType + DBTab_User
        return eval(funName)()  # eval 将其中的字符串转化为python表达式

    @staticmethod
    def CreateDepartment():
        funName = DBType + DBTab_Department
        return eval(funName)()


def clientUI():
    printInfo("\n--------抽象工厂方法--------")
    factory = SqlServerFactory()
    iu = factory.CreateUser()
    iu.Insert()
    iu.GetUser()
    id = factory.CreateDepartment()
    id.Insert()
    id.GetUser()

    printInfo("\n--抽象工厂方法+简单工厂方法--")
    iu = DataAccess.CreateUser()
    iu.Insert()
    iu.GetUser()
    id = DataAccess.CreateDepartment()
    id.Insert()
    id.GetUser()

    printInfo("\n-抽象工厂方法+简单工厂方法+反射-")
    iu = DataAccessPro.CreateUser()
    iu.Insert()
    iu.GetUser()
    id = DataAccessPro.CreateDepartment()
    id.Insert()
    id.GetUser()
    return


if __name__ == '__main__':
    clientUI();
