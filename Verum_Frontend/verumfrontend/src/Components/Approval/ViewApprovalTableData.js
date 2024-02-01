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
  Checkbox

} from "@chakra-ui/react";
import { useEffect, useState } from "react";

const ViewApprovalTableData = ({ trigger, CurrentApprovalItem, ModalTitle }) => {
  const { isOpen, onOpen, onClose } = useDisclosure();
  const [approverOneEmail, setapproverOneEmail] = useState([]);
  const [approverTwoEmail, setapproverTwoEmail] = useState([]);
  const [approverThreeEmail, setapproverThreeEmail] = useState([]);
  const [refCode, setrefCode] = useState([]);
  const [documentNumber, setdocumentNumber] = useState([]);
  const [approvalAmount, setapprovalAmount] = useState([]);
  const [approvalFinal, setapprovalFinal] = useState([]);
  const TriggerModal = () => {
    onOpen();
    setapproverOneEmail(CurrentApprovalItem.approverOneEmail);
    setapproverTwoEmail(CurrentApprovalItem.approverTwoEmail);
    setapproverThreeEmail(CurrentApprovalItem.approverThreeEmail);
    setrefCode(CurrentApprovalItem.refCode);
    setapprovalAmount(CurrentApprovalItem.approvalAmount);
    setdocumentNumber(CurrentApprovalItem.documentNumber);
    setapprovalFinal(CurrentApprovalItem.approvalFinal)

  }
  useEffect(() => {
    TriggerModal();
  }, [trigger]);

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
                            <FormLabel>Ref Code</FormLabel>
                            <Input placeholder='Ref Code' value={refCode} disabled={!refCode}/>
                        </FormControl>

                        <FormControl mt={4}>
                            <FormLabel>Approval One Email</FormLabel>
                            <Input placeholder='Approval One Email' value={approverOneEmail} disabled={!approverOneEmail} />
                        </FormControl>
                        <FormControl mt={4}>
                            <FormLabel>Approval Two Email</FormLabel>
                            <Input  placeholder='Approval Two Email' value={approverTwoEmail} disabled={!approverTwoEmail} />
                        </FormControl>
                        <FormControl mt={4}>
                            <FormLabel>Approval Three Email</FormLabel>
                            <Input  placeholder='Approval Three Email' value={approverThreeEmail} disabled={!approverThreeEmail} />
                        </FormControl>
                        <FormControl mt={4}>
                            <FormLabel>Document Number</FormLabel>
                            <Input placeholder='Document Number' value={documentNumber} disabled={!documentNumber}/>
                        </FormControl>
                        <FormControl mt={4}>
                            <FormLabel>Approval Amount</FormLabel>
                            <Input placeholder='Approval Amount' value={approvalAmount}  disabled={!approvalAmount}/>
                        </FormControl>
                        <FormControl mt={4}>
                            <FormLabel>Approval Final</FormLabel>
                            <Input placeholder='Approval Final' value={approvalFinal} disabled={!approvalFinal}/>
                        </FormControl>
        
                    </ModalBody>


          <ModalFooter>
            <Button onClick={onClose}>Close</Button>
          </ModalFooter>
        </ModalContent>
      </Modal>
    </>
  );
};

export default ViewApprovalTableData;


