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
  useToast,

} from "@chakra-ui/react";
import { useEffect, useState } from "react";

const ViewCostCenterTableData = ({ CurrentCostCenterItem, ModalTitle, triggercost }) => {
  const { isOpen, onOpen, onClose } = useDisclosure();
  const [CostCenterCode, setCostCenterCode] = useState([]);
  const [TitleCostCenter, setTitleCostCenter] = useState([]);
  const [TitleEnglishCostCenter, setTitleEnglishCostCenter] = useState([]);
  const [FlagProfitCenter, setFlagProfitCenter] = useState(false);
  const [DescriptionCostCenter, setDescriptionCostCenter] = useState([]);
  const [Id, setId] = useState([]);
  console.log('first', triggercost);
  const toast = useToast();
  const TriggerModal = () => {
    onOpen();
    setCostCenterCode(CurrentCostCenterItem.costCenterCode);
    setTitleCostCenter(CurrentCostCenterItem.titleCostCenter);
    setTitleEnglishCostCenter(CurrentCostCenterItem.titleEnglishCostCenter);
    setFlagProfitCenter(CurrentCostCenterItem.flagProfitCenter);
    setDescriptionCostCenter(CurrentCostCenterItem.descriptionCostCenter);
    setId(CurrentCostCenterItem.id);

  }
  useEffect(() => {
    TriggerModal();
  }, [triggercost]);

  const UpdateProfileHandler = async () => {
    const response = await axios.put('https://localhost:7226/Tables/UpdatetCostCenter', {
      CostCenterCode, TitleCostCenter, TitleEnglishCostCenter,
      FlagProfitCenter, DescriptionCostCenter, Id
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
              <FormLabel>SCHLUSSEL</FormLabel>
              <Input placeholder='SCHLUSSEL' value={CostCenterCode} onChange={(e) => setCostCenterCode(e.target.value)} />
            </FormControl>

            <FormControl mt={4}>
              <FormLabel>TITEL</FormLabel>
              <Input placeholder='TITEL' value={TitleCostCenter} onChange={(e) => setTitleCostCenter(e.target.value)} />
            </FormControl>
            <FormControl mt={4}>
              <FormLabel>TITEL ENGLISCH</FormLabel>
              <Input placeholder='TITEL ENGLISCH' value={TitleEnglishCostCenter} onChange={(e) => setTitleEnglishCostCenter(e.target.value)} />
            </FormControl>
            <FormControl mt={4}>
              <FormLabel>KOSTENTRAGER</FormLabel>
              <input type='radio' checked={FlagProfitCenter} placeholder='KOSTENTRAGER' onChange={() => setFlagProfitCenter(!FlagProfitCenter)} />
            </FormControl>
            <FormControl mt={4}>
              <FormLabel>BESCHREIBUNG</FormLabel>
              <Input type="paragraph" placeholder='BESCHREIBUNG' value={DescriptionCostCenter} onChange={(e) => setDescriptionCostCenter(e.target.value)} />
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

export default ViewCostCenterTableData;
