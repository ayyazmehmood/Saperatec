import React, { useState, useEffect } from 'react'
import axios from 'axios'
import { Tabs, TabList, TabPanels, Tab, TabPanel, Icon } from '@chakra-ui/react'
import {
  Table,
  Thead,
  Tbody,
  Tr,
  Th,
  Td,
  Button,
  TableCaption,
  TableContainer, Card, Menu, MenuList, useToast
} from '@chakra-ui/react'
import { DeleteIcon, EditIcon } from '@chakra-ui/icons'
import ViewCostCenterTableData from '../Utility/ViewCostCenterTableData'
import AddCostCenter from '../CostCenter/AddCostCenter'
import AddAuthority from '../CostCenter/AddAuthority'
import ViewAuthorityTableData from '../Utility/ViewAuthorityTableData'
import ViewApprovalTableData from '../Approval/ViewApprovalTableData'
import { abc, bca } from '../apiService/costcenterService'
import httpRequest from '../httpService/http.request';


export default function SqlTables() {
  const httpReq=new httpRequest()
  const [Id, setId] = useState([])
  const [Costcenterdata, setCostcenterdata] = useState([])
  const [Authoritydata, setAuthoritydata] = useState([])
  const [Approvaldata, setApprovaldata] = useState([])
  const [CurrentCostCenterItem, SetCurrentCostCenterItem] = useState([]);
  const [CurrentAuthItem, SetCurrentAuthItem] = useState([]);
  const [CurrentApprovalItem, SetCurrentApprovalItem] = useState([]);
  const [IsCostView, setIsCostView] = useState(false);
  const [IsAuthView, setIsAuthView] = useState(false);
  const [IsApprovalView, setApprovalView] = useState(false);
  const [IsAddNewCost, setIsAddNewCost] = useState(false);
  const [IsAddNewAuth, setIsAddNewAuth] = useState(false);
  const [triggercost, settriggercost] = useState(false);
  const [triggercostadd, settriggercostadd] = useState(false);
  const [triggerapproval, settriggerapproval] = useState(false);
  const [triggerapprovaladd, settriggerapprovaladd] = useState(false);
  const [triggerauth, settriggerauth] = useState(false);
  const [currentPageCostCenter, setCurrentPageCostCenter] = useState(1);
  const [currentPageAuth, setCurrentPageAuth] = useState(1);
  const [currentPageApproval, setCurrentPageApproval] = useState(1);
  const [itemsPerPage] = useState(15); // Change this to the number of items per page

  const toast = useToast();
  const fetchTablesData = async () => {
    try {
      const rescostcenter = await httpReq.get('GetTcostcenterTable');
      setCostcenterdata(rescostcenter.data);
    } catch (error) {
      toast({
        title: "something Went Wrong",
        status: "error",
        duration: 3000,
        isClosable: true,
        position: "bottom",
      });
    }
    try {
      const resauthority = await httpReq.get('GetTAuthority');
      setAuthoritydata(resauthority.data);

    } catch (error) {
      toast({
        title: "something Went Wrong",
        status: "error",
        duration: 3000,
        isClosable: true,
        position: "bottom",
      });
    }

    try {
      const resapproval = await httpReq.get('GetTApproval');
      setApprovaldata(resapproval.data);

    } catch (error) {
      toast({
        title: "something Went Wrong",
        status: "error",
        duration: 3000,
        isClosable: true,
        position: "bottom",
      });
    }
  }
  useEffect(() => {
    fetchTablesData();
  }, [])

  const AddCostRowHandler = () => {
    setIsAddNewCost(true);
    settriggercostadd(!triggercostadd);
  }

  const AddAuthRowHandler = () => {
    setIsAddNewAuth(true);
    settriggerapprovaladd(!triggerapprovaladd);
  }

  const clickcostcenterhandler = (item) => {
    setIsCostView(true);
    SetCurrentCostCenterItem(item);
    settriggercost(!triggercost);
  }

  const deletecostcenterhandler = async (item) => {
    const Id = item.id;
    try {
      const res = await httpReq.post(`DeleteTCostCenter`, { Id });
      if (res.status == 200) {
        toast({
          title: res.data,
          status: "error",
          duration: 3000,
          isClosable: true,
          position: "bottom",
        });
        fetchTablesData();
      }
      else {
        toast({
          title: "Something Went Wrong",
          status: "error",
          duration: 3000,
          isClosable: true,
          position: "bottom",
        });
      }

    } catch (error) {
      toast({
        title: "something Went Wrong",
        status: "error",
        duration: 3000,
        isClosable: true,
        position: "bottom",
      });
    }

  }
  const clickauthhandler = (item) => {
    setIsAuthView(true);
    SetCurrentAuthItem(item);
    settriggerauth(!triggerauth);
  }

  const deleteauthhandler = async (item) => {
    try {
      const Id = item.id;
      const res = await httpReq.post(`DeletetAuthority`, { Id });   
      if (res.status == 200) {
        toast({
          title: res.data,
          status: "error",
          duration: 3000,
          isClosable: true,
          position: "bottom",
        });
        fetchTablesData();
      }
      else {
        toast({
          title: "Something Went Wrong",
          status: "error",
          duration: 3000,
          isClosable: true,
          position: "bottom",
        });
      } 
    } catch (error) {
      toast({
        title: "something Went Wrong",
        status: "error",
        duration: 3000,
        isClosable: true,
        position: "bottom",
      });
    }

  }

  const clickapprovalhandler = (item) => {
    setApprovalView(true);
    SetCurrentApprovalItem(item);
    settriggerapproval(!triggerapproval);
  }

  const indexOfLastItemCostCenter = currentPageCostCenter * itemsPerPage;
  const indexOfFirstItem = indexOfLastItemCostCenter - itemsPerPage;
  const currentCostCenterItems = Costcenterdata.slice(indexOfFirstItem, indexOfLastItemCostCenter);

  const indexOfLastItemApproval = currentPageApproval * itemsPerPage;
  const indexOfFirstItemApproval = indexOfLastItemApproval - itemsPerPage;
  const currentApprovalItems = Approvaldata.slice(indexOfFirstItemApproval, indexOfLastItemApproval);

  const indexOfLastItemAuthority = currentPageAuth * itemsPerPage;
  const indexOfFirstItemAuthority = indexOfLastItemAuthority - itemsPerPage;
  const currentAuthorityItems = Authoritydata.slice(indexOfFirstItemAuthority, indexOfLastItemAuthority);

  // Change page
  const paginatecost = pageNumber => setCurrentPageCostCenter(pageNumber);
  const paginateauth = pageNumberauth => setCurrentPageAuth(pageNumberauth);
  const paginateapproval = pageNumberapproval => setCurrentPageApproval(pageNumberapproval);

  return (
    <Card style={{ borderRadius: '20px', marginTop: '5%' }}>

      <Tabs variant='soft-rounded' margin={"3"}>
        <TabList>
          <Tab _selected={{ color: 'white', bg: 'blue.500' }}>Cost Center Table</Tab>
          <Tab _selected={{ color: 'white', bg: 'green.400' }}>Authority Table</Tab>
          <Tab _selected={{ color: 'white', bg: 'red.400' }}>Approval Table</Tab>
        </TabList>
        <TabPanels>
          <TabPanel>
            <TableContainer>
              <Table variant='simple'>
                <TableCaption><Button onClick={() => { AddCostRowHandler(triggercostadd) }}>Add</Button></TableCaption>
                <Thead>
                  <Tr>
                    <Th>Schlussel</Th>
                    <Th>Titel</Th>
                    <Th>Titel englisch</Th>
                    <Th >Kostentrager</Th>
                    <Th >Beschreibung</Th>
                    <Th >View</Th>
                    <Th >Delete</Th>
                  </Tr>
                </Thead>
                <Tbody>
                  {currentCostCenterItems.map((item) =>
                    <Tr>
                      <Td>{item.costCenterCode}</Td>
                      <Td>{item.titleCostCenter ? item.titleCostCenter.slice(0, 20) + '...' : ''}</Td>
                      <Td>{item.titleEnglishCostCenter ? item.titleEnglishCostCenter.slice(0, 20) + '...' : ''}</Td>
                      <Td >{item.flagProfitCenter ? 'true' : 'false'}</Td>
                      <Td>{item.descriptionCostCenter ? item.descriptionCostCenter.slice(0, 20) + '...' : ''}</Td>
                      <Td><Button onClick={() => { clickcostcenterhandler(item, triggercost) }} >View</Button></Td>
                      <Td><DeleteIcon onClick={() => { deletecostcenterhandler(item) }} style={{ cursor: 'pointer' }} /></Td>
                    </Tr>
                  )}
                </Tbody>
              </Table>
              <div style={{ display: 'flex', justifyContent: 'center' }}>
                {Array.from({ length: Math.ceil(Costcenterdata.length / itemsPerPage) }, (_, i) => (
                  <Button style={currentPageCostCenter==(i+1)?{background:'gray'}:{}} key={i + 1} onClick={() => paginatecost(i + 1)} margin={1}>
                    {i + 1}
                  </Button>
                ))}
              </div>
            </TableContainer>
            {IsCostView && <ViewCostCenterTableData triggercost={triggercost} CurrentCostCenterItem={CurrentCostCenterItem} />}
            {IsAddNewCost && <AddCostCenter triggercost={triggercostadd} />}
          </TabPanel>
          <TabPanel>
            <TableContainer>
              <Table variant='simple'>
                <TableCaption><Button onClick={() => { AddAuthRowHandler(triggerapprovaladd) }}>Add Authority</Button></TableCaption>
                <Thead>

                  <Tr>
                    <Th>Cost Center</Th>
                    <Th>User Role</Th>
                    <Th>Apporaval Limit</Th>
                    <Th>Ref Code</Th>
                    <Th >View</Th>
                    <Th >Delete</Th>
                  </Tr>
                </Thead>
                <Tbody>
                  {currentAuthorityItems.map((item) =>
                    <Tr>
                      <Td>{item.costCenter}</Td>
                      <Td>{item.userRole}</Td>
                      <Td>{item.approvalLimit}</Td>
                      <Td>{item.refCode ? item.refCode : '-'}</Td>
                      <Td><Button onClick={() => { clickauthhandler(item, triggerauth) }} >View</Button></Td>
                      <Td><DeleteIcon onClick={() => { deleteauthhandler(item) }} style={{ cursor: 'pointer' }} /></Td>
                    </Tr>
                  )}

                </Tbody>

              </Table>
              <div style={{ display: 'flex', justifyContent: 'center' }}>
                {Array.from({ length: Math.ceil(Authoritydata.length / itemsPerPage) }, (_, i) => (
                  <Button style={currentPageAuth==(i+1)?{background:'gray'}:{}} key={i + 1} onClick={() => paginateauth(i + 1)} margin={1}>
                    {i + 1}
                  </Button>
                ))}
              </div>
            </TableContainer>
            {IsAuthView && <ViewAuthorityTableData triggerauth={triggerauth} CurrentAuthItem={CurrentAuthItem} Onupdate={fetchTablesData} />}
            {IsAddNewAuth && <AddAuthority triggerauthadd={triggerapprovaladd} Onadd={fetchTablesData} />}
          </TabPanel>
          <TabPanel>
            <TableContainer>
              <Table variant='simple'>
                <Thead>
                  <Tr>
                    <Th >Ref Code</Th>
                    <Th>Approval One Email</Th>
                    <Th>Approval Two Email</Th>
                    <Th>Approval Three Email</Th>
                    <Th>Document Number</Th>
                    <Th>Approval Amount</Th>
                    <Th>Approval Final</Th>
                    <Th>View</Th>
                  </Tr>
                </Thead>
                <Tbody>
                  {currentApprovalItems.map((item) =>
                    <Tr>
                      <Td>{item.refCode}</Td>
                      <Td>{item.approverOneEmail}</Td>
                      <Td>{item.approverTwoEmail}</Td>
                      <Td>{item.approverThreeEmail}</Td>
                      <Td>{item.documentNumber}</Td>
                      <Td>{item.approvalAmount}</Td>
                      <Td>{item.approvalFinal}</Td>
                      <Td><Button onClick={() => { clickapprovalhandler(item, triggerapproval) }} >View</Button></Td>
                    </Tr>
                  )}

                </Tbody>

              </Table>
              <div style={{ display: 'flex', justifyContent: 'center' }}>
                {Array.from({ length: Math.ceil(Approvaldata.length / itemsPerPage) }, (_, i) => (
                  <Button style={currentPageApproval==(i+1)?{background:'gray'}:{}} key={i + 1} onClick={() => paginateapproval(i + 1)} margin={1}>
                    {i + 1}
                  </Button>
                ))}
              </div>
            </TableContainer>
            {IsApprovalView && <ViewApprovalTableData CurrentApprovalItem={CurrentApprovalItem} ModalTitle={"Approval"} trigger={triggerapproval} />}
          </TabPanel>
        </TabPanels>
      </Tabs>
    </Card>
  )
}
