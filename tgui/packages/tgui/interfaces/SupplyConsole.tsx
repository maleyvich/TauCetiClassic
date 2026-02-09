import { useBackend } from '../backend';
import { Button, Box, Divider, Dropdown, Stack } from '../components';
import { Window } from '../layouts';

type Data = {
  location: string;
  credits: number;
  depnumber: number;
  tax: number;
  deliverycost: number;
  discount: number;
  profits: number;
};

export const SupplyConsole = (props, context) => {
  const { act, data } = useBackend<Data>(context);
  const { location, credits, depnumber, tax, deliverycost, discount, profits } =
    data;

  return (
    <Window width={540} height={640}>
      <Window.Content>
        <Box width="100%" textAlign="center">
          Supply shuttle Location: {location}
        </Box>
        <Divider />
        <Stack>
          <Stack.Item width="100%" textAlign="base">
            Cargo Dep credits: {credits}$
          </Stack.Item>
          <Stack.Item>Cargo Dep Number: {depnumber}</Stack.Item>
          <Stack.Item>Export tax: {tax}%</Stack.Item>
        </Stack>
        <Divider />
        <Stack>
          <Stack.Item width="100%" textAlign="base">
            ГрузТорг delivery cost:
          </Stack.Item>
          <Stack.Item>
            <Button
              mt={1}
              content={deliverycost}
              onClick={() => act('onlineshopdeliverycost')}
            />
          </Stack.Item>
          <Stack.Item>ГрузТорг discount:</Stack.Item>
          <Stack.Item>
            <Button
              mt={1}
              content={discount}
              onClick={() => act('onlineshopdeliverycost')}
            />
          </Stack.Item>
          <Stack.Item>ГрузТорг profits: {profits}</Stack.Item>
        </Stack>
        <Stack>
          <Stack.Item>
            <Button
              mt={1}
              content={'Order items'}
              onClick={() => act('order')}
            />
          </Stack.Item>
          <Stack.Item>
            <Button
              mt={1}
              content={'Send to station'}
              onClick={() => act('order')}
            />
          </Stack.Item>
          <Stack.Item>
            <Button
              mt={1}
              content={'View requests'}
              onClick={() => act('order')}
            />
          </Stack.Item>
          <Stack.Item>
            <Button
              mt={1}
              content={'View approved orders'}
              onClick={() => act('order')}
            />
          </Stack.Item>
          <Stack.Item>
            <Button
              mt={1}
              content={'View Centcom message'}
              onClick={() => act('order')}
            />
          </Stack.Item>
        </Stack>
      </Window.Content>
    </Window>
  );
};
