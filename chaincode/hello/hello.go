
package main

import (
	"encoding/json"
	"fmt"
	"github.com/hyperledger/fabric/core/chaincode/shim"
	sc "github.com/hyperledger/fabric/protos/peer"
)


type THello struct {
	Id 		string	`json:"id"`
	Name 	string 	`json:"name"`
}



func (t *THello) Init(APIstub shim.ChaincodeStubInterface) sc.Response {
	return shim.Success(nil)
}

func (t *THello) Invoke(APIstub shim.ChaincodeStubInterface) sc.Response {

	function, args := APIstub.GetFunctionAndParameters()

	if function == "getWithId" {
		return t.getWithId(APIstub, args)
	} else if function == "setObj" {
		return t.setObj(APIstub, args)
	}

	return shim.Error("Invalid Smart Contract function name.")
}



func (t *THello) setObj(APIstub shim.ChaincodeStubInterface, args []string) sc.Response {

	if len(args) != 2 {
		return shim.Error("参数异常")
	}

	tHello := THello{
		Id: 	args[0],
		Name: 	args[1],
	}
	tHelloAsBytes, _ := json.Marshal(tHello)
	APIstub.PutState(tHello.Id, tHelloAsBytes)

	//返回添加的值
	return shim.Success(tHelloAsBytes)

}

func (t *THello) getWithId(APIstub shim.ChaincodeStubInterface, args []string) sc.Response {

	if len(args) != 1 {
		return shim.Error("参数异常")
	}

	//查询
	tHelloAsBytes, err := APIstub.GetState(args[0])
	if err != nil {
		return shim.Error("查询异常")
	}

	//判断是否存在
	if len(tHelloAsBytes) == 0 {
		return shim.Error("查询失败，Id不存在")
	}

	return shim.Success(tHelloAsBytes)

}


func main() {
	err := shim.Start(new(THello))
	if err != nil {
		fmt.Printf("Error creating new Smart Contract: %s", err)
	}
}
