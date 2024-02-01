import axios from "axios";
import {
    Modal,
    ModalOverlay,
    ModalContent,
    ModalHeader,
    ModalFooter,
    ModalBody,
    ModalCloseButton,
    Button,
    useDisclosure,
    FormLabel,
    Input,
    FormControl,
    useToast

} from "@chakra-ui/react";
import { useEffect, useState } from "react";
import httpRequest from '../httpService/http.request';

const AddAuthority = ({ triggerauthadd, Onadd }) => {
    const { isOpen, onOpen, onClose } = useDisclosure();
    const [costCenter, setcostCenter] = useState([]);
    const [refCode, setrefCode] = useState([]);
    const [approvalLimit, setapprovalLimit] = useState([]);
    const [userRole, setuserRole] = useState([]);
    const httpReq=new httpRequest()
    const toast = useToast();

    const clearState = () => {
        setcostCenter([]);
        setrefCode([]);
        setapprovalLimit([]);
        setuserRole([]);
        
    }
    const TriggerModal = () => {
        onOpen();
    }
    useEffect(() => {
        TriggerModal();
    }, [triggerauthadd]);

    const AddAuthority = async () => {
        const response = await httpReq.post('AddtAuthority', {
            costCenter, refCode, approvalLimit,
            userRole
          });
          try {
            if (response.status == 200) {
              toast({
                title: response.data,
                status: "success",
                duration: 3000,
                isClosable: true,
                position: "bottom",
              });
              Onadd();
            } else {
              toast({
                title: response.data,
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
          onClose();
        clearState();

    }

    return (
        <>
            <Modal
                isOpen={isOpen}
                onClose={onClose}
            >
                <ModalOverlay />
                <ModalContent>
                    <ModalHeader>Add Authority </ModalHeader>
                    <ModalCloseButton />
                    <ModalBody pb={6}>
                        <FormControl>
                            <FormLabel>Cost Center</FormLabel>
                            <Input placeholder='Cost Center' value={costCenter} onChange={(e) => setcostCenter(e.target.value)} />
                        </FormControl>

                        <FormControl mt={4}>
                            <FormLabel>ApprovalLimit</FormLabel>
                            <Input type='number' placeholder='TITEL' value={approvalLimit} onChange={(e) => setapprovalLimit(e.target.value)} />
                        </FormControl>
                        <FormControl mt={4}>
                            <FormLabel>Ref Code</FormLabel>
                            <Input placeholder='Ref Code' value={refCode} onChange={(e) => setrefCode(e.target.value)} />
                        </FormControl>
                        <FormControl mt={4}>
                            <FormLabel>User Role</FormLabel>
                            <Input type='number'  placeholder='User Role' value={userRole} onChange={(e) => setuserRole(e.target.value)} />
                        </FormControl>
        
                    </ModalBody>

                    <ModalFooter>
                        {
                            <Button colorScheme='blue' mr={3} onClick={() => AddAuthority()}>
                                Add
                            </Button>
                        }

                        <Button onClick={onClose}>Cancel</Button>
                    </ModalFooter>
                </ModalContent>
            </Modal>
        </>
    );
};

export default AddAuthority;
