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


export default function SqlTables() {
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
  const [IsAddNew, setIsAddNew] = useState(false);
  const [triggercost, settriggercost] = useState(false);
  const [triggercostadd, settriggercostadd] = useState(false);
  const [triggerapproval, settriggerapproval] = useState(false);
  const [triggerauth, settriggerauth] = useState(false);
  const [trigger, settrigger] = useState(false);
  const [currentPageCostCenter, setCurrentPageCostCenter] = useState(1);
  const [currentPageAuth, setCurrentPageAuth] = useState(1);
  const [currentPageApproval, setCurrentPageApproval] = useState(1);
  const [itemsPerPage] = useState(15); // Change this to the number of items per page

  const toast = useToast();
  const fetchTablesData = async () => {
    const rescostcenter = await axios.get('https://localhost:7226/Tables/GetTcostcenterTable');
    setCostcenterdata(rescostcenter.data);

    const resauthority = await axios.get('https://localhost:7226/Tables/GetTAuthority');
    setAuthoritydata(resauthority.data);

    const resapproval = await axios.get('https://localhost:7226/Tables/GetTApproval');
    setApprovaldata(resapproval.data);
  }
  useEffect(() => {
    fetchTablesData();
  }, [])

  const AddCostRowHandler = () => {
    setIsAddNew(true);
    settriggercostadd(!triggercostadd);
  }

  const AddAuthRowHandler = () => {
    setIsAddNew(true);
    settriggerauth(!triggerauth);
  }

  const clickcostcenterhandler = (item) => {
    setIsCostView(true);
    SetCurrentCostCenterItem(item);
    settriggercost(!triggercost);
  }

  const deletecostcenterhandler = async (item) => {
    const Id = item.id;

    const res = await axios.post(`https://localhost:7226/Tables/DeleteTCostCenter`, { Id });
    if (res.status == 200) {
      toast({
        title: res.data,
        status: "error",
        duration: 3000,
        isClosable: true,
        position: "bottom",
      });
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

  }
  const clickauthhandler = (item) => {
    setIsAuthView(true);
    SetCurrentAuthItem(item);
    settriggerauth(!triggerauth);
  }

  const deleteauthhandler = async (item) => {
    const Id = item.id;
    const res = await axios.post(`https://localhost:7226/Tables/DeletetAuthority`, { Id });
  }

  const clickapprovalhandler = (item) => {
    setApprovalView(true);
    SetCurrentApprovalItem(item);
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
              <Table variant='striped ' colorScheme='teal'>
                <TableCaption><Button onClick={() => { AddCostRowHandler() }}>Add Cost Center</Button></TableCaption>
                <Thead>
                  <Tr>
                    <Th>Schlussel</Th>
                    <Th>Titel</Th>
                    <Th>Titel englisch</Th>
                    <Th >Kostentrager</Th>
                    <Th >Beschreibung</Th>
                    <Th >BudgetResponsible</Th>
                    <Th >ExecutiveApprover</Th>
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
                      <Td>{item.idBudgetResponsibleUserName}</Td>
                      <Td>{item.idExecutiveApproverUserName}</Td>
                      <Td><Button onClick={() => { clickcostcenterhandler(item, triggercost) }} >View</Button></Td>
                      <Td><DeleteIcon onClick={() => { deletecostcenterhandler(item) }} style={{ cursor: 'pointer' }} /></Td>
                    </Tr>
                  )}

                </Tbody>
              </Table>
              <div >
                <div>
                  {Array.from({ length: Math.ceil(Costcenterdata.length / itemsPerPage) }, (_, i) => (
                    <Button
                      key={i + 1}
                      onClick={() => paginatecost(i + 1)}
                      style={{ backgroundColor: currentPageCostCenter === i + 1 ? '#007bff' : 'transparent', color: currentPageCostCenter === i + 1 ? 'white' : 'black' }}
                      margin={1}
                    >
                      {i + 1}
                    </Button>
                  ))}
                </div>
              </div>
            </TableContainer>
            {IsCostView && <ViewCostCenterTableData triggercost={triggercost} CurrentCostCenterItem={CurrentCostCenterItem} />}
            {IsAddNew && <AddCostCenter triggercost={triggercostadd} />}
          </TabPanel>
          <TabPanel>
            <TableContainer>
              <Table variant='striped ' colorScheme='teal'>
                <TableCaption><Button onClick={() => { AddAuthRowHandler() }}>Add Authority</Button></TableCaption>
                <Thead>

                  <Tr>
                    <Th>Cost Center</Th>
                    <Th>User Role</Th>
                    <Th>Apporaval Limit</Th>
                    <Th>UserName</Th>
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
                      <Td>{item.userName}</Td>
                      <Td><Button onClick={() => { clickauthhandler(item, trigger) }} >View</Button></Td>
                      <Td><DeleteIcon onClick={() => { deleteauthhandler(item) }} style={{ cursor: 'pointer' }} /></Td>
                    </Tr>
                  )}

                </Tbody>

              </Table>
              <div>
                {Array.from({ length: Math.ceil(Authoritydata.length / itemsPerPage) }, (_, i) => (
                  <Button key={i + 1} onClick={() => paginateauth(i + 1)} margin={1}
                  style={{ backgroundColor: currentPageAuth === i + 1 ? '#007bff' : 'transparent', color: currentPageAuth === i + 1 ? 'white' : 'black' }}
                  >
                    {i + 1}
                  </Button>
                ))}
              </div>
            </TableContainer>
            {IsAuthView && <ViewAuthorityTableData triggerauth={triggerauth} CurrentAuthItem={CurrentAuthItem} />}
            {IsAddNew && <AddAuthority triggerauth={triggerauth} />}
          </TabPanel>
          <TabPanel>
            <TableContainer>
              <Table variant='striped ' colorScheme='teal'>
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
                      <Td><Button onClick={() => { clickapprovalhandler(item, triggerauth) }} >View</Button></Td>
                    </Tr>
                  )}

                </Tbody>

              </Table>
              <div>
                {Array.from({ length: Math.ceil(Approvaldata.length / itemsPerPage) }, (_, i) => (
                  <Button key={i + 1} onClick={() => paginateapproval(i + 1)} margin={1}
                  style={{ backgroundColor: currentPageApproval === i + 1 ? '#007bff' : 'transparent', color: currentPageApproval === i + 1 ? 'white' : 'black' }}
                  >
                    {i + 1}
                  </Button>
                ))}
              </div>
            </TableContainer>
            {IsApprovalView && <ViewApprovalTableData CurrentApprovalItem={CurrentApprovalItem} ModalTitle={"Approval"} trigger={trigger} />}
          </TabPanel>
        </TabPanels>
      </Tabs>
    </Card>
  )
}
