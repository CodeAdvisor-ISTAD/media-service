package co.istad.media_service.base;

import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@Builder
@AllArgsConstructor
public class BasedResponse<T> {
    private T payload;
}
