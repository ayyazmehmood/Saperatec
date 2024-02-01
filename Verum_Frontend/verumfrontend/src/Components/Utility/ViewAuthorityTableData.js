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
  Checkbox,
  useToast

} from "@chakra-ui/react";
import { useEffect, useState } from "react";

const ViewAuthorityTableData = ({ triggerauth, CurrentAuthItem, ModalTitle, Onupdate }) => {
  const { isOpen, onOpen, onClose } = useDisclosure();
  const [costCenter, setcostCenter] = useState([]);
  const [refCode, setrefCode] = useState([]);
  const [approvalLimit, setapprovalLimit] = useState([]);
  const [userRole, setuserRole] = useState([]);
  const [Id, setId] = useState([]);
  const toast = useToast();
  console.log('triggerauth', triggerauth);
  const TriggerModal = () => {
    onOpen();
    setcostCenter(CurrentAuthItem.costCenter);
    setrefCode(CurrentAuthItem.refCode);
    setapprovalLimit(CurrentAuthItem.approvalLimit);
    setuserRole(CurrentAuthItem.userRole);
    setId(CurrentAuthItem.id)

  }
  useEffect(() => {
    TriggerModal();
  }, [triggerauth]);

  const UpdateProfileHandler = async () => {
    const response = await axios.put('https://localhost:7226/Tables/UpdatetAuthority', {
      costCenter, refCode, approvalLimit,
      userRole, Id
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
        Onupdate();
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

  }

  return (
    <>
      <Modal
        isOpen={isOpen}
        onClose={onClose}
      >
        <ModalOverlay />
        <ModalContent>
          <ModalHeader>{ModalTitle}</ModalHeader>
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
              <input type='number' placeholder='User Role' value={userRole} onChange={() => setuserRole(userRole)} />
            </FormControl>

          </ModalBody>


          <ModalFooter>
            {
              <Button colorScheme='blue' mr={3} onClick={() => UpdateProfileHandler()}>
                Save
              </Button>
            }

            <Button onClick={onClose}>Cancel</Button>
          </ModalFooter>
        </ModalContent>
      </Modal>
    </>
  );
};

export default ViewAuthorityTableData;
